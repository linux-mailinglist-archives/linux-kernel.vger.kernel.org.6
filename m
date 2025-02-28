Return-Path: <linux-kernel+bounces-539182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90AA4A1BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1181E188D382
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F76E1F8754;
	Fri, 28 Feb 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRaidpjF"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4971F873B;
	Fri, 28 Feb 2025 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767678; cv=none; b=pxjw0BDIVQaIaNwx8/l+0e7oGDc8U18Fnxketxug198rM1lAkr/N47UUTeonv0KS497HhbOuBis3FkeGCExG8bSnw2TozqHKd+p/EqBKMGrsVMGF4MgD6B+2zov5pzhNRr8aDbdHmb53J5CMo2deuyNj9t9saEotVUr8ksrpFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767678; c=relaxed/simple;
	bh=wZP5dwHjFXIR2Zc7eVavD2zM6CWmbdreeu6wNJalJsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtsxtJvds3UoVBaaVQWRtyjrMOJHf323lktgtNALsm6bIJ+gBSCO5iZzh0k2pQnxnSqU6hQ9hkPPtU3d8GdPM9mCPi/le4UGgf7s6g+C4+6aFGZcOdgok9cUUWb2WDEeqfQ614IX3HWW1sKISGvp6/zLz3UWNJjsP5Sf9vU1ifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRaidpjF; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47210ab1283so35516571cf.1;
        Fri, 28 Feb 2025 10:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740767676; x=1741372476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCFqw9auaprjfKRzf7+Y1mLRgmmsiKR+TkaoqiWHMBc=;
        b=cRaidpjFNVKQsM1WYKWxs8d8wTWaEKFCZkBCGcivJByGF49K5JzysCL5lu7IZosy4c
         F1op875/DDAvDzkIylVlgqsdBGRjkp8mdU7SlIFBerQBOCejJOOPeNZ+Uo5YQLz51BSm
         Gy8D8P8cq49wgrKyY13W2uDbx4SeddsFdH0cDnN//vYoeK1is9ogEK0OHLeVPVW+1KjB
         +cKS7K2H5bZKtsSQUL8oCZjdMCYgynlEUfg1YxY5rZTkA5PvRu76QeEgKYcMy8JpeELN
         B1JwohJK7hQJMKTUDG6YwCfLD1rHRi0KJc0vIHx7abPEC2vChi/KSbCStIRobuj4Z/XY
         3H7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767676; x=1741372476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCFqw9auaprjfKRzf7+Y1mLRgmmsiKR+TkaoqiWHMBc=;
        b=PyOPuy60FvVVlFeuSFh49yunHGD1tabsmT4COI+bNz2hE3F85fVhnS+XRra5/kLMWB
         SoEst/aj0i2YUzNYoeXBbiS8bGUOsVzMiL+shF3CKhDScLQtnkK0t88JdBUGUAdfFMn8
         w27r8VyFW1gKlTdjWZTUGt447LdLQYOBiVUcIJFGDDyvZ/k6BJOLyDt/JSqXn8hNIJ90
         vfbShpD5cxlG1uM9iHjLoyFgZ92wHiouYoPLeTEge4QmlZCNF4GWNvqIU63kaXxKiB05
         Pnm3l39Y7nheYumFpVkGhbNi9thkMfG73fc42E4tLOIHk2j18/EOqWSSZfZ9DgLjShZR
         SIxw==
X-Forwarded-Encrypted: i=1; AJvYcCUEu6WfzEF1gC1XtLIB4Vo30AxBsnEOdH9bHe2IMSq32Vwi0IGx3uhq6C0lFysH6ZPRNOOZV3BNRt8szkE=@vger.kernel.org, AJvYcCUy1HTzRdS/RYneVPrZlnJLwfcFIPMMNTS7QsAK3qmRbsJKfFj2rAVwJ7KTbWnSmemkSzx9MOv2SagLwXgVZFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNpRZisg2ciL0Sl4Tt/34ceEA/hbfZu3NE80lGrqnbxMe0qBpu
	ryYbZosFYP8CzlKBLQT7QwtuP/uCuGH7HVFSaIy+8yILjAprrHS5
X-Gm-Gg: ASbGncv20qPmVB2VSEYjKDtUT8GvF3jpDFCQXQtu+LadsstES1erZThT/5O0n8ArdGC
	C/8yQ77UNN0mni8LVkff2JrSn96RIPqK4kMLffIiYnwsjITeHs2hNg8h6fSbjEB0rmiHLa66eps
	XIkFNaDMwef6MZ57cBZjcs0oJ7kb0w9tW1wB7s6gbQhCxaEi83pY5a1LlSwX3JQgneuT/eDZZ38
	kZzLvqTPUk1G64cp8dMPli79v3aA5iipGpzHBFKicKWcoulnPEEzhq6+UMO3z7CcdJc3MWkG4Fx
	+/oFq7iqMC14Qwxjc5SWlUEYlF5vpy+MsTwAJZABfAETrVnt+TAjF6U1uHGMHsaciUSJHtvTRRB
	hw6jvl5nPQDDvMkIH
X-Google-Smtp-Source: AGHT+IGj0YxFiFBDDT0v4MfFSXaWM+4kzchKYmFHxIBIpXJ1G+JPxmQ1BGzcIDkMywjicWdbGuaEqQ==
X-Received: by 2002:a05:620a:4727:b0:7c0:b08d:2432 with SMTP id af79cd13be357-7c39c4a555fmr761792185a.8.1740767675719;
        Fri, 28 Feb 2025 10:34:35 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fef5a83sm276178985a.31.2025.02.28.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:34:35 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id DABE11200068;
	Fri, 28 Feb 2025 13:34:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 28 Feb 2025 13:34:34 -0500
X-ME-Sender: <xms:ugHCZ_-x1-LtgnS0sbhG4lGdfpTrqZrkPRAI00q3NOlfEjWE1ejn8g>
    <xme:ugHCZ7v_y-DQjb9EcFx-Fdnru_uUHDStIJoCUvWMooBYtg9x6AAEGs7OfoRpyr2mw
    HwIE1KPhJMqtxORRw>
X-ME-Received: <xmr:ugHCZ9A8YuDo5Y6ZqkBStDvdoAkOzRSFlA3TVuHnJ7f5fcI4_ev5EPXd2_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeludduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopeholhhivhgvrhdrmhgrnhhgohhlugesphhmrdhmvgdprhgtphhtthhopegrrdhhihhn
    uggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorh
    hnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhl
    ohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrlhhitggvrhihhhhlsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:ugHCZ7cwGoFYk6sozroVZAkzHwD7uBMl0cKDwKVp33xIQ16Oazux1A>
    <xmx:ugHCZ0Ps4laHNB5taA36w9lYkpbH85favwxLMaCX4VhO7Tb2DEBsiw>
    <xmx:ugHCZ9lmjUdJze5aUk4cpisvKUkISijl6SCxsPLdP9FarwPNWwO8IA>
    <xmx:ugHCZ-tRRfL0znolIusuKpJVKG0e94312LHyVR7uZGzR5kAZLcykxQ>
    <xmx:ugHCZ-vPccaJfhgd0T9pZfjt-NF2lml5TM19fyHeeceN0RLIpJWjv0qo>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 13:34:34 -0500 (EST)
Date: Fri, 28 Feb 2025 10:33:44 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8IBiBi6CSRxfxiE@boqun-archlinux>
References: <I2EuahEO9YG75qdfIlsanLJ9iOfr0OlKJr6nw_cqOG0rVrZUEZGhdfENkLawNCpSqP8uSGMODCeEmsYv6clgYg==@protonmail.internalid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <I2EuahEO9YG75qdfIlsanLJ9iOfr0OlKJr6nw_cqOG0rVrZUEZGhdfENkLawNCpSqP8uSGMODCeEmsYv6clgYg==@protonmail.internalid>

On Fri, Feb 28, 2025 at 06:22:58PM +0000, Oliver Mangold wrote:
> On 250228 1009, Boqun Feng wrote:
> > 
> > Please add the "# Examples" section as I requested:
> > 
> > 	https://lore.kernel.org/rust-for-linux/Z8HcHVtPiG-X6ujP@Mac.home/
> > 
> > I also would like to know why do you think it's OK to ignore my previous
> > comment, thanks!
> > 
> 
> I intend to. Don't worry. I totally have it in mind that, this is missing.
> As said, I will do it in a couple of days. Sorry if the update
> caused confusion.
> 

I should appologize as well, after re-reading the email exchange between
us, I realized I wasn't clear about whether my request was including the
tests with the patch or not. So it's reasonable you thought a separate
patch would work.

Now as we cleared things, I want to make sure that it's clear that I
would like to see the patch with examples in it. 

> I am aware this won't be the final version, but I thought
> I still post this one correctly formatted, as Miguel requested.
> 

Yes, I figured that's what you planned to do, although it's better if
you could provide some information between versions, one example would
be:

	https://lore.kernel.org/rust-for-linux/20250227193522.198344-1-lyude@redhat.com/

i.e. you can add some description after the "---" line, and that won't
affect git to apply the patches. Usually people put changes between
versions, and in this case since you just want to update a version that
is not the final version, you can add some description about that there
as well.

> I assure you, I'm not ignoring your comment and request at all.
> 

Thanks! Again, sorry for not being clear in previous emails.

Regards,
Boqun

> Oliver
> 

