Return-Path: <linux-kernel+bounces-252491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2209C9313D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F6FB21383
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DEA18A957;
	Mon, 15 Jul 2024 12:15:01 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CF23BF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045700; cv=none; b=k7sFGo6qWypcC0Qunzv9Atur62i70OhA/2ZpQXvfeT3iw76E/pNeuzq/HbfUWbmviYvIeUJpunBIrjdusFZfk+9eMEv2+Rr3hBhKe0w+9Uv9sLK7RZU+AsMVbFkX98SzM0Z3pm4LZ3zgCklsouNFWviqAg5tqzxDru1/Zl+5Tzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045700; c=relaxed/simple;
	bh=tRIlbmDMhmWEUzPRiVEkLl3AwQdR4a3tBQ3K0qzrmLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl7Aey+iVf6obgW+r2xDZxcMIHC8QqIzfIdc0gtFcQM6RvAfLvRXoge52CY018301QDPpNSO6bYHGFkMN7IcQClIlMHhfVSLA+qTsUDybHNMsMHixDcZ/87cfS9090duTDZR9gE1dMh7wGFu5TakLTcJWybh/Yn9H6h8SvNbPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38027so4431073a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721045697; x=1721650497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj5Gg43Az4DAnwfCesaZ9uO5GLfF2QEJvK6nOqg2Cn8=;
        b=T3idJ0nwgXqlazMW+QLWRO4nQj5t4VIZgwx13lnas38Wm5qwlcHnGK36tQTYaH7CQr
         pXpSfs6Q3+Dgv8RrzZ/qYYz05WAwzLfa93cVmpoyT2cZKxy+CSS8MYNqNpQ352b+MI45
         EeBNyvJYCp/eTHC/l+ifN8Fp8Yd5aIvjaHOWxdD7hZJ6HWIxWRzicI3NHBFw2kvhLN7q
         7H4kBypsxv9dmGWDrsN5ZQ0xCKDtrEWfjRfVBZN2lZ8JesjNDULlXnSx9fEJWxpXqFTU
         JAFDdW0LNGQJZeoAB1it0QU34uT+Ne4ouC5U0qzLmrfeLJd/kNlyUOXfGJ7fY3r2WdS0
         SGJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3lWABTz1b2+ySujUW52kKs2sQ3mOU6VPLHjbOqFnG+9fECc1n0xGkUVWGwVcpI0PdgTXBDaW02UL0qkNyftiPhXlPUFypQSz1ScgI
X-Gm-Message-State: AOJu0YzDKgyb45rcNffNEwfDDG80kTqkJ+kBE7wPGaKaJWHe0SwguTnp
	C89e9BaqeoGCHUQ2+oS3vjU7K4+BPUw0LHMo9eo6HOTtW4kmo5Zu
X-Google-Smtp-Source: AGHT+IEQXdXi6YONA6xJoxuVoiFxUfM8cQRJMK2TGkvtsL9JX2DmFstcuiM1up0Pgg6ljAusRyEG1A==
X-Received: by 2002:a17:907:764b:b0:a6f:53f9:7974 with SMTP id a640c23a62f3a-a780b882f28mr1376023566b.52.1721045697325;
        Mon, 15 Jul 2024 05:14:57 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5e8609sm207906966b.94.2024.07.15.05.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:14:57 -0700 (PDT)
Date: Mon, 15 Jul 2024 05:14:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] x86/bugs: Add a separate config for GDS
Message-ID: <ZpUSvl5eKgkLeJrg@gmail.com>
References: <20240422165830.2142904-1-leitao@debian.org>
 <20240422165830.2142904-2-leitao@debian.org>
 <20240712172132.GFZpFmHBJHte2xS1fr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712172132.GFZpFmHBJHte2xS1fr@fat_crate.local>

Hello Borislav,

On Fri, Jul 12, 2024 at 07:21:32PM +0200, Borislav Petkov wrote:
> On Mon, Apr 22, 2024 at 09:58:15AM -0700, Breno Leitao wrote:
> > +config MITIGATION_GDS
> > +	bool "Mitigate Gather Data Sampling"
> > +	depends on CPU_SUP_INTEL
> > +	default y
> > +	help
> > +	  Enable mitigation for Gather Data Sampling (GDS). GDS is a hardware
> > +	  vulnerability which allows unprivileged speculative access to data
> > +	  which was previously stored in vector registers. The attacker uses gather
> > +	  instructions to infer the stale vector register data.
> > +
> >  config MITIGATION_GDS_FORCE
> 
> Btw, can we get rid of that thing, while at it?

Sure, I will send a v4 and get rid of GDS_FORCE_MITIGATION completely.

Thanks for the review.

--breno

