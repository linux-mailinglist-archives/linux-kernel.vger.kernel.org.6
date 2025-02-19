Return-Path: <linux-kernel+bounces-521198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E198A3B766
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B87A78C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2181BD9DE;
	Wed, 19 Feb 2025 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="hZbi+bNX"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442441DE2C5;
	Wed, 19 Feb 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956128; cv=none; b=ZqTh4QBNybHKRt1bUcU+HcTTB35hZVTMXpD09ts4N8/0FqowFhk3NFOtFcu+vfei8YjF/1ziBWCVpGd6NGJY/JrWg7/b1OAERJnChE1hu2N7NWhn2oXcK0RwA2R9LcK4Fy26DGpSSPLANhPRZGMP75OGIyzUx14Uwi/bd/7KhrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956128; c=relaxed/simple;
	bh=Z1bk0dL1MwViW5c8wTOmV9AYMz3fjx9VzE2Lsv1NMZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3xGJP7iDWgzmkqtkHKfaRlWyAjs95IDK5U7TjHQz71sUQXzq9wb8IiscEkBox+IRAZniwpd+Rc/969LZjlRqS9vhv80ZTnKCpJTRa5Xtxxh0L6Bzp1MsXMMhevjGXlgTN9R6OqIP0GdI7EBZTDBQ/HqWnMJD/1Bi+Fgskg2Wtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=hZbi+bNX; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7786148313E;
	Wed, 19 Feb 2025 10:08:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1739956117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nN7IHpShWJBpsyykGmnOLHdtsNK5mxWDwUr79QicVDo=;
	b=hZbi+bNXalt75rPd6UHgk6ItE5xeqlHKA5Cgg0jsaoqecodXIHTiSLZyrFTFdlVt5UjMHm
	ykm4EDPeEllisKaltxXDOUZjFZbSRySVuMrc0TbrSXP97bcuiM3DrW4x4Tj8CLJ9pkEgnq
	DJkdWOpa7lFmG9dicxS0FZGPlbwCaPQfGoDFjVSemPr9WUGgP5sSHMUUIzvQW3fvnw0qF7
	xVFn5NJJi1/1EsAvw0f57cAwCbYMNzNGXtTLd90MnHMqhnN4GE19uD/GsBiyBoSYzcyLw0
	8ENt+C8JDSVztKQpdYHqirNV1E2IhrjEDwN3VGjUNrdS2pNTpVTDbznk+7/WOA==
Date: Wed, 19 Feb 2025 10:08:30 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Dahl <ada@thorsis.com>
Subject: Re: [PATCH v2 01/16] dt-bindings: clock: at91: Split up per SoC
 partially
Message-ID: <20250219-cornfield-rekindle-2addbd8db308@thorsis.com>
Mail-Followup-To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
References: <20250210164506.495747-1-ada@thorsis.com>
 <20250210164506.495747-2-ada@thorsis.com>
 <a1dff4af-d771-4424-869f-15d3b6bca013@tuxon.dev>
 <20250217-shortwave-scoreless-38cb49fe5548@thorsis.com>
 <a99ab8eb-274b-449c-8bb6-be9422c5b2a2@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a99ab8eb-274b-449c-8bb6-be9422c5b2a2@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

Am Wed, Feb 19, 2025 at 10:51:40AM +0200 schrieb Claudiu Beznea:
> Hi, Alexander,
> 
> On 17.02.2025 11:47, Alexander Dahl wrote:
> > Hello Claudiu,
> > 
> > Am Mon, Feb 17, 2025 at 11:11:44AM +0200 schrieb Claudiu Beznea:
> >> Hi, Alexander,
> >>
> >> On 10.02.2025 18:44, Alexander Dahl wrote:
> >>> Before adding even more new indexes creating more holes in the
> >>> clk at91 drivers pmc_data->chws arrays, split this up.
> >>>
> >>> This is a partial split up only for SoCs affected by upcoming changes
> >>> and by that PMC_MAIN + x hack, others could follow by the same scheme.
> >>>
> >>> Binding splitup was proposed for several reasons:
> >>>
> >>> 1) keep the driver code simple, readable, and efficient
> >>> 2) avoid accidental array index duplication
> >>> 3) avoid memory waste by creating more and more unused array members.
> >>>
> >>> Old values are kept to not break dts, and to maintain dt ABI.
> >>>
> >>> Link: https://lore.kernel.org/linux-devicetree/20250207-jailbird-circus-bcc04ee90e05@thorsis.com/T/#u
> >>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> >>> ---
> >>>
> >>> Notes:
> >>>     v2:
> >>>     - new patch, not present in v1
> >>>
> >>>  .../dt-bindings/clock/microchip,sam9x60-pmc.h | 19 +++++++++++
> >>>  .../dt-bindings/clock/microchip,sam9x7-pmc.h  | 25 +++++++++++++++
> >>>  .../clock/microchip,sama7d65-pmc.h            | 32 +++++++++++++++++++
> >>>  .../dt-bindings/clock/microchip,sama7g5-pmc.h | 24 ++++++++++++++
> >>>  4 files changed, 100 insertions(+)
> >>>  create mode 100644 include/dt-bindings/clock/microchip,sam9x60-pmc.h
> >>>  create mode 100644 include/dt-bindings/clock/microchip,sam9x7-pmc.h
> >>>  create mode 100644 include/dt-bindings/clock/microchip,sama7d65-pmc.h
> >>>  create mode 100644 include/dt-bindings/clock/microchip,sama7g5-pmc.h
> >>>
> >>
> >> [ ...]
> >>
> >>> diff --git a/include/dt-bindings/clock/microchip,sama7g5-pmc.h b/include/dt-bindings/clock/microchip,sama7g5-pmc.h
> >>> new file mode 100644
> >>> index 0000000000000..ad69ccdf9dc78
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/clock/microchip,sama7g5-pmc.h
> >>> @@ -0,0 +1,24 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> >>> +/*
> >>> + * The constants defined in this header are being used in dts and in
> >>> + * at91 sama7g5 clock driver.
> >>> + */
> >>> +
> >>> +#ifndef _DT_BINDINGS_CLOCK_MICROCHIP_SAMA7G5_PMC_H
> >>> +#define _DT_BINDINGS_CLOCK_MICROCHIP_SAMA7G5_PMC_H
> >>> +
> >>> +#include <dt-bindings/clock/at91.h>
> >>> +
> >>> +/* old from before bindings splitup */
> >>> +#define SAMA7G5_PMC_MCK0	PMC_MCK		/* 1 */
> >>> +#define SAMA7G5_PMC_UTMI	PMC_UTMI	/* 2 */
> >>> +#define SAMA7G5_PMC_MAIN	PMC_MAIN	/* 3 */
> >>> +#define SAMA7G5_PMC_CPUPLL	PMC_CPUPLL	/* 4 */
> >>> +#define SAMA7G5_PMC_SYSPLL	PMC_SYSPLL	/* 5 */
> >>> +
> >>> +#define SAMA7G5_PMC_AUDIOPMCPLL	PMC_AUDIOPMCPLL	/* 9 */
> >>> +#define SAMA7G5_PMC_AUDIOIOPLL	PMC_AUDIOIOPLL	/* 10 */
> >>> +
> >>> +#define SAMA7G5_PMC_MCK1	PMC_MCK1	/* 13 */
> >>> +
> >>> +#endif
> >>
> >> I would have expected this to be something like:
> >>
> >> #ifndef __DT_BINDINGS_CLOCK_MICROCHIP_SAMA7G5_PMC_H__
> >> #define __DT_BINDINGS_CLOCK_MICROCHIP_SAMA7G5_PMC_H__
> >>
> >> /* Core clocks. */
> >> #define SAMA7G5_MCK0			1
> >> #define SAMA7G5_UTMI			2
> >> #define SAMA7G5_MAIN			3
> >> #define SAMA7G5_CPUPLL			4
> >> #define SAMA7G5_SYSPLL			5
> >> #define SAMA7G5_DDRPLL			6
> >> #define SAMA7G5_IMGPLL			7
> >> #define SAMA7G5_BAUDPLL			8
> > 
> > Okay no reference to the old header, but numbers.  Got that.
> > 
> > I'm not sure where you got the 7 and 8 from here, according to my
> > analysis, sama7g5 does not use those.
> 
> From include/dt-bindings/clock/at91.sh
> 
> #define PMC_IMGPLL              (PMC_MAIN + 4)
> 
> #define PMC_BAUDPLL             (PMC_MAIN + 5)

Okay fine, but those defines are not used anywhere in the whole kernel
as of v6.14-rc3, also not by sama7g5 clock driver.  Are those used in
a different version or tree?  Should I rebase?

Or do you want the whole SAMA7G5 section moved away from
include/dt-bindings/clock/at91.sh already?  Then this would be four
steps, right?

1. introduce the new defines
2. use the new defines in driver
3. use the new defines in dt
4. remove the old defines

(Same for SAM9X7 and SAMA7D65 sections?)

Or is this out of scope for this series?

> 
> 
> > 
> >>
> >> // ...
> >>
> >> #define SAMA7G5_MCK1			13
> >>
> >> #endif /* __DT_BINDINGS_CLOCK_MICROCHIP_SAMA7G5_PMC_H__ */
> >>
> >> Same for the other affected SoCs.
> >>
> >> The content of include/dt-bindings/clock/at91.h would be limited eventually
> >> only to the PMC clock types.
> > 
> > What does this mean?  The clocks split out are no PMC clocks?  
> 
> Still PMC clocks. Keeping the types in separate header allows keeping the
> code PMC code common for all SoCs. Then the newly added headers will be
> used only in the SoC DTes and SoC clock driver (e.g. in your case
> drivers/clk/at91/sam9x60.c)

I understand this as: PMC_TYPE_CORE, PMC_TYPE_SYSTEM, etc. will stay
in include/dt-bindings/clock/at91.h as they are, but the IDs for core
clocks I started to split out will be removed eventually?

Then I would have to change my patch to slightly rename the new
defines and use the static numbers instead of referencing the old
defines, but besides that it's fine?

Correct me, if I understood that wrong.

Thanks and Greets
Alex

> 
> > Then
> > the old PMC_MAIN etc. definitions were named wrong?  All or only some
> > of them?  Or is this different between older and newer SoC variants of
> > the at91 family?
> > 
> > From a quick glance in the SAM9X60 datasheet for example the clock
> > generator provides MD_SLCK, TD_SLCK, MAINCK, and PLL clocks, while the
> > PMC provides MCK, USB clocks, GCLK, PCK, and the peripheral clocks.
> 
> drivers splits this into:
> - core clocks
> - peripheral clocks
> - generic clocks
> - system clocks
> - programmable
> 
> It's how the code sees it, just a logical split.
> 
> Thank you,
> Claudiu
> 
> > 
> > The chws array in drivers/clk/at91/sam9x60.c however gets main_rc_osc
> > (from clock generator), mainck (clock generator), pllack (clock
> > generator), upllck (clock generator, UTMI), but also mck (from PMC).
> > 
> > This creates the impression things are mixed up here.  I find all this
> > quite confusing to be honest.
> > 
> >> The other "#define PMC_*" defines will eventually go to SoC specific
> >> bindings. "#define AT91_PMC_*" seems to not belong here anyway and these
> >> would in the end removed, as well.
> > 
> > Okay, you seem to have an idea how this should look like in the long
> > run.  Are there any plans at Microchip or at91 clock maintainer side
> > to clean this up in the near future?
> > 
> > I would like to rather put my small changes for otpc on top of a clean
> > tree, instead of trying to clean up clock drivers and bindings for a
> > whole family of SoCs and boards, where I can test only one of them.
> > O:-)
> > 
> > Greets
> > Alex
> > 
> 

