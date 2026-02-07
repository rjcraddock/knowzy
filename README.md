# Knowzy (cc by 4.0)

A nostr-native polling platform where respondents own their data, build dimensional profiles over time, and earn sats for their answers.

## The Vision

Knowzy flips the traditional survey model: instead of companies extracting value from your opinions while you get entered into gift card raffles, you get paid directly in sats for every answer. Your responses build a portable dimensional profile that you control. The more consistent and engaged you are, the more valuable you become in the marketplace.

Question askers can target specific audiences with precision: "suburban parents who care about privacy" or "fiscal conservatives under 40." The more specific the targeting, the higher the payment per response. All targeting dimensions are transparent and based on your previous answers.

Over time, the system tracks consistency. If your answers align with your stated values and past responses, your reputation grows. If they conflict, you can reset your profile - but you lose your history and start over. The result is a marketplace for coherent perspectives where truth and consistency have economic value.

## Why This Matters

**Sovereignty:** Your dimensional profile is yours. It's portable across nostr. You can export it, reset it, or delete it. No platform lock-in.

**Aligned Incentives:** Respondents earn the majority of payment. The platform takes a small percentage for sustainability, but value flows to those doing the work.

**Transparent Indexes:** The categories and dimensions used for targeting are visible. No hidden algorithmic sorting, no opaque recommendation systems.

**Decentralized Infrastructure:** Built on nostr for identity and Lightning for payments. Censorship-resistant, portable, and interoperable.

## Architecture Overview

### Data Model

The core is a flexible dimensional profiling system:

- **Users** have demographic data (age, location, income) and accumulated dimensional profiles based on their answers
- **Questions** can target specific dimensional groups and offer sats per response
- **Seed Questions** bootstrap new users into the system by establishing baseline dimensions
- **DimGroup → DimType → MultiDim** hierarchy enables arbitrarily complex audience targeting without schema changes
- **Consistency Tracking** compares new answers against historical responses to build reputation scores

See `/schema/Knowzyddl.txt` for the complete SQL schema.

### Payment Flow

1. Question creator deposits sats to fund their question (via Lightning invoice)
2. Question becomes active and is shown to targeted respondents
3. First N respondents to answer receive payment (additional answers allowed but unpaid)
4. Sats are distributed to respondent Lightning addresses
5. Platform fee (5%) is deducted during deposit

### Nostr Integration

- User identity via npub/nsec keys
- Questions published as nostr events (specific NIP TBD)
- Dimensional profiles stored as nostr events for portability
- Zaps (NIP-57) for Lightning payments where applicable
- Relay infrastructure for event distribution

### Seed Questions

New users must answer 10-20 seed questions before accessing the broader question pool. These establish:
- Age range
- Location (country/region)
- Income bracket  
- Core interests (via tags)
- Optional: political leaning, parenting status, occupation

Users are paid small amounts (platform-funded) for seed answers to teach the core loop and ensure profile completion.

## Current State

**What exists:**
- Complete database schema (SQL Server, convertible to Postgres)
- Conceptual architecture for consistency tracking
- Payment flow design
- Seed question strategy

**What's missing:**
- Frontend implementation
- Lightning integration (invoice generation, payment verification, payout distribution)
- Nostr event publishing and relay coordination
- Seed question content
- Consistency scoring algorithm implementation
- User authentication and key management
- Question creation UI
- Results visualization

This is an early-stage project. The data model is solid and battle-tested thinking, but the application layer needs to be built.

## Technical Decisions

**Database:** Postgres (schema currently in SQL Server DDL, trivial to convert)

**Backend:** Suggest Python (Flask/FastAPI) for rapid development and strong Postgres/Lightning library support

**Frontend:** Recommend HTMX + TailwindCSS for simplicity - interactive UI without heavy JavaScript framework complexity

**Nostr:** Use existing libraries (nostr-sdk for Python, nostr-tools for JS) rather than reinventing

**Lightning:** Integrate with existing Lightning infrastructure (LND, Alby API, etc.) rather than running own node initially

## Getting Started (Future)

*Note: Implementation not yet complete. This section describes the intended developer experience.*

```bash
# Clone the repository
git clone https://github.com/rjcraddock/knowzy.git
cd knowzy

# Set up database
createdb knowzy
psql knowzy < schema/knowzy_postgres.sql

# Install dependencies
pip install -r requirements.txt

# Configure environment
cp .env.example .env
# Add your Lightning credentials, Nostr relay URLs, etc.

# Run migrations (future)
python manage.py migrate

# Start development server (future)
python app.py
```

## MVP Scope Recommendation

For anyone picking this up, here's a realistic MVP:

1. **User onboarding:** Nostr login, seed question flow, Lightning address setup
2. **Basic polling:** Display questions, accept answers, show simple result percentages
3. **Payment:** Escrow sats for questions, pay first N respondents
4. **Minimal targeting:** Tag-based filtering only (skip complex dimensional matching initially)
5. **Seed questions:** 10 hardcoded questions covering demographics and interests

This proves the core loop: sign up → answer questions → earn sats → build profile.

Advanced features (consistency tracking, complex targeting, question creation UI, public results browsing) can come after the basic marketplace works.

## Contributing

This project is open for contributors. If you understand the vision and want to build it:

**High priority needs:**
- Frontend developer (Python/HTMX or React/Next.js)
- Lightning integration specialist
- Nostr protocol expertise
- Seed question content creation
- UX/UI design

**How to contribute:**
- Check existing issues for known work
- Open an issue to discuss major changes before building
- Follow the data model - it's designed to be flexible, but schema changes should be carefully considered
- Keep the incentives aligned - users own their data and earn from their participation

## Philosophy

From the creator:

> "He who controls the indexes controls the future. Every recommendation you see, every search result, every 'people like you also...' is an index someone else built, optimized for their interests, not yours."

Knowzy is an attempt to build a different kind of index: one that users control, that benefits them financially, that's transparent in its operation, and that prioritizes truth over engagement.

The dimensional profiling system isn't surveillance - it's user-owned metadata that creates value for both question askers (precise targeting) and respondents (higher pay for valuable profiles). The consistency tracking isn't about punishment - it's about creating a marketplace where coherent, thoughtful perspectives are rewarded.

Build this with sovereignty and aligned incentives as first principles. If those are compromised, the whole thing fails.

## License

MIT License - cc by 4.0 

## Links

- Creator's Nostr: nostr.jimcraddock.com
- Related writing: www.redactedscience.org
- Discussions: Use GitHub issues or reach out on Nostr

---

*This is incomplete work, shared openly. Someone with more runway might pick it up and carry it forward. The architecture is here. The vision is documented. Build it better than I could have.*
