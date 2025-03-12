Return-Path: <linux-kernel+bounces-558242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E48A5E358
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1705B17ABC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174C224419B;
	Wed, 12 Mar 2025 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJe5CU02"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F61D54FE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802449; cv=none; b=bfYKdlk5529j2vCx4LJpdFXv2NM7cUa2E48S3Ikc7u5Y5kQmzYocOtB4EBIlxj16NxqQN25fhLYljv7ZCOB/u8wCRzmFe27plN/Mw2zzPAV7Jobo0X/mivDaSPx5Q95AQjypCCCPIcQ8K4QJCPiMo34bnD+VzhTBXc3V5KkfUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802449; c=relaxed/simple;
	bh=HN1FCCnOPEE1t9kDpU0yT04ErPNnu/s1L++w4bo0Eyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0Sv6o7B2gwnhQa5Ka/5u8h2QVMyY45g3WtTnkOvvj/BhrV/pot0fCmelQ0J31cF18/RFyD4WrjfBKAISdoF9P+7+H31iHsw1fMP6Yc79vs6vxrkQh0F2TDLTtBKtM/Bnsn0NhxANc6muOMOmdnCOoEpFHoQTVD/qrjlBs4NOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJe5CU02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4796C4CEDD;
	Wed, 12 Mar 2025 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741802448;
	bh=HN1FCCnOPEE1t9kDpU0yT04ErPNnu/s1L++w4bo0Eyk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nJe5CU02GRqxawUj3zBmpDi9uypIV37zQ6ZHT4HmzeJonfYaFdBq8I8cx6dpmlqQt
	 ZxEWrXQQNjUtDJ9rtkWmugwVVT8zTZzDvLzXfGidPvut94rz5VcphYane24BWGgPpH
	 EGOvWc/yeTadVLE1WI6oaY+56Tphly0MY0Vwk4Ye3+Csh9qldIDLF/SAzyKPaCSCIl
	 aJraceyr5Aj6TQ0UclTtuWH+oA2QdoTIO6y9+oTO+J8hJMX3Pg2BBVpndEf/KC17dJ
	 EYyMxndQbBD7eZGzTM75dDF+SVZJ1bqK1Zbi3EyX2R/i1Jz+MhwRSd+NrE8OgQiX/J
	 OtGX/zH41eYAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 68F38CE1401; Wed, 12 Mar 2025 11:00:48 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:00:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel <linux-kernel@vger.kernel.org>, frederic@kernel.org
Subject: Re: [GIT PULL] Generic entry for ARM
Message-ID: <1277cefd-b080-42a5-bfe5-57296e7ccc3e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CACRpkdZCiiMTwf7eGJJ9aCKFOC3_xTGv1JKQUijjyp+_++cZ_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZCiiMTwf7eGJJ9aCKFOC3_xTGv1JKQUijjyp+_++cZ_A@mail.gmail.com>

On Fri, Feb 28, 2025 at 01:49:36PM +0100, Linus Walleij wrote:
> Hi Russell,
> 
> please consider pulling the following git branch for generic entry,
> see below.
> 
> This branch was just harvested from my own v5 patch series on
> lore with b4 am -t 20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org
> then git am on top of v6.14-rc1, so you can do the same if you
> prefer.
> 
> It's possible to squash patches, even all of them into one
> big all-or-nothing patch, given the not very gradual nature generic
> entry conversion seems to have.
> 
> Main upsides and downsides are in the signed tag.
> 
> I don't know who the most important stakeholders are, but I guess
> the context tracker maintainer (Paul McKenney) and the people working
> on generic entry (tglx) could have a say on how important this is, or isn't.
> 
> I think it's pretty neat.

No argument here!

Once you are confident that you have all the needed "noinstr"
and "__always_inline" instances in place, could you please add
ARCH_WANTS_NO_INSTR to the list of "select" clauses for "config ARM"
in arch/arm/Kconfig?

Once all architectures that support trampoline-based tracing also select
ARCH_WANTS_NO_INSTR we can drop RCU Tasks Rude.  ;-)

In the meantime, for the series:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> Yours,
> Linus Walleij
> 
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/arm-generic-entry-for-v6.15
> 
> for you to fetch changes up to 98b8e133458a3feefdf882ea16fb7f1f576a49e5:
> 
>   ARM: entry: Reimplement local restart in C (2025-02-28 13:40:44 +0100)
> 
> ----------------------------------------------------------------
> Main upsides:
> 
> - Using the same common entry as used by x86_64, RISCV, S390
>   and Loongarch, probably soon also ARM64.
> 
> - Moves ARM away from the obsoleted context tracker entry points
>   user_enter_callable() and user_exit_callable() are now only used
>   by ARM, CSKY and Xtensa.
> 
> - Solves a few lockdep warnings in the process.
> 
> - Converts a bit of assembly into C.
> 
> Main downside:
> 
> - Slightly increased system call overhead, around 6% in
>   measurements.
> 
> ----------------------------------------------------------------
> Linus Walleij (31):
>       ARM: Prepare includes for generic entry
>       ARM: ptrace: Split report_syscall()
>       ARM: entry: Skip ret_slow_syscall label
>       ARM: process: Rewrite ret_from_fork i C
>       ARM: process: Remove local restart
>       ARM: entry: Invoke syscalls using C
>       ARM: entry: Rewrite two asm calls in C
>       ARM: entry: Move trace entry to C function
>       ARM: entry: save the syscall sp in thread_info
>       ARM: entry: move all tracing invocation to C
>       ARM: entry: Merge the common and trace entry code
>       ARM: entry: Rename syscall invocation
>       ARM: entry: Create user_mode_enter/exit
>       ARM: entry: Drop trace argument from usr_entry macro
>       ARM: entry: Separate call path for syscall SWI entry
>       ARM: entry: Drop argument to asm_irqentry macros
>       ARM: entry: Implement syscall_exit_to_user_mode()
>       ARM: entry: Drop the superfast ret_fast_syscall
>       ARM: entry: Remove fast and offset register restore
>       ARM: entry: Untangle ret_fast_syscall/to_user
>       ARM: entry: Do not double-call exit functions
>       ARM: entry: Move work processing to C
>       ARM: entry: Stop exiting syscalls like IRQs
>       ARM: entry: Complete syscall and IRQ transition to C
>       ARM: entry: Create irqentry calls from kernel mode
>       ARM: entry: Move in-kernel hardirq tracing to C
>       ARM: irq: Add irqstack helper
>       ARM: entry: Convert to generic entry
>       ARM: entry: Handle dabt, pabt, and und as interrupts
>       ARM: entry: Block IRQs in early IRQ context
>       ARM: entry: Reimplement local restart in C
> 
>  arch/arm/Kconfig                    |   1 +
>  arch/arm/include/asm/entry-common.h |  66 ++++++++++++
>  arch/arm/include/asm/entry.h        |  14 +++
>  arch/arm/include/asm/ptrace.h       |   8 +-
>  arch/arm/include/asm/signal.h       |   4 -
>  arch/arm/include/asm/stacktrace.h   |   2 +-
>  arch/arm/include/asm/switch_to.h    |   4 +
>  arch/arm/include/asm/syscall.h      |   7 ++
>  arch/arm/include/asm/thread_info.h  |  22 ++--
>  arch/arm/include/asm/traps.h        |   5 +-
>  arch/arm/include/uapi/asm/ptrace.h  |   2 +
>  arch/arm/kernel/Makefile            |   5 +-
>  arch/arm/kernel/asm-offsets.c       |   1 +
>  arch/arm/kernel/entry-armv.S        |  82 ++++-----------
>  arch/arm/kernel/entry-common.S      | 198 +++++++++++++-----------------------
>  arch/arm/kernel/entry-header.S      | 100 ++----------------
>  arch/arm/kernel/entry.c             | 120 ++++++++++++++++++++++
>  arch/arm/kernel/irq.c               |   6 ++
>  arch/arm/kernel/irq.h               |   2 +
>  arch/arm/kernel/process.c           |  25 ++++-
>  arch/arm/kernel/ptrace.c            |  81 +--------------
>  arch/arm/kernel/signal.c            |  68 +++----------
>  arch/arm/kernel/syscall.c           |  59 +++++++++++
>  arch/arm/kernel/traps.c             |  30 +-----
>  arch/arm/mm/abort-ev4.S             |   2 +-
>  arch/arm/mm/abort-ev4t.S            |   2 +-
>  arch/arm/mm/abort-ev5t.S            |   4 +-
>  arch/arm/mm/abort-ev5tj.S           |   6 +-
>  arch/arm/mm/abort-ev6.S             |   2 +-
>  arch/arm/mm/abort-ev7.S             |   2 +-
>  arch/arm/mm/abort-lv4t.S            |  36 +++----
>  arch/arm/mm/abort-macro.S           |   2 +-
>  arch/arm/mm/abort-nommu.S           |   2 +-
>  arch/arm/mm/fault.c                 |   4 +-
>  arch/arm/mm/fault.h                 |   8 +-
>  arch/arm/mm/pabort-legacy.S         |   2 +-
>  arch/arm/mm/pabort-v6.S             |   2 +-
>  arch/arm/mm/pabort-v7.S             |   2 +-
>  38 files changed, 484 insertions(+), 504 deletions(-)
>  create mode 100644 arch/arm/include/asm/entry-common.h
>  create mode 100644 arch/arm/include/asm/entry.h
>  create mode 100644 arch/arm/kernel/entry.c
>  create mode 100644 arch/arm/kernel/irq.h
>  create mode 100644 arch/arm/kernel/syscall.c

