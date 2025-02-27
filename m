Return-Path: <linux-kernel+bounces-535235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D92A4706C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A707E1658DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CC63A1BA;
	Thu, 27 Feb 2025 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmueIcE1"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4904C70;
	Thu, 27 Feb 2025 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616917; cv=none; b=tfChIw4xOWQLAYb+y2VD/QBpAIZPsP2P81211/jHbxYZ5stW2YmXp/ARweAjk68UPEuVEvNgX/eLmlsNvPZJXJ//cw+JCOBe0DJcfUbAvJrpoq23FWUDsLkgImHAB0upOEugyuVzDFVerqtXXC3SQk2Oug2r89vkTqbh67NLsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616917; c=relaxed/simple;
	bh=juddtVXsAGH0JUdA8WnPjcU5Ys1P4Wg9AIMJy9BwsQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgHs71dXw2kMxk03j1Q0OlTuK0COJmrL3SjP8C24ddcGCkqQQBn4n6Gqo9r84I2mvYBICxSgHP0wWG51laMyg6Bzc5gZxeKreBMEOMc/rydTDB0wdp+sFnAaSAjr5LRrpqnuzIDfB6Ucm5waSNe0vqpWrBvpRWHUo2aHvz4WREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmueIcE1; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0b0ca6742so43936785a.0;
        Wed, 26 Feb 2025 16:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740616915; x=1741221715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBYtztjxLyrkD0HRV/UOGdGGNoqugc5RDu2qyVaSfBg=;
        b=DmueIcE12qALU3NWuqpoI3ZVVd4a3Pc7up/ue4alPcL0Se5Rqcc1/OYZPikyKTp44S
         PEqlXTQhDWQM6unpVLR4EO78hmcGkJdjkX/W4mZZlGxBNbdR4U73iA/5oXcSwPk0KpU9
         a/VINFZpsxOynE5FYpsT8K9DSHuxXIbvI9XnTz39C/ZYBh9daN1Dzi8sRUUKhBqLWRqR
         7bo54htx+/vOnkyisKk2HilzBJJhr84HyQnwDNZ3/cZuCPGvdQyLxBU34U5rV93XfjNW
         hhaN+3aOw/nx6iKjYPFIgESdF370Zw4j4f7j5o4xud3Liq38+5Q/eUooaAMGtzoHfKas
         Xuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616915; x=1741221715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBYtztjxLyrkD0HRV/UOGdGGNoqugc5RDu2qyVaSfBg=;
        b=YUXx1wnTl3q/k824KDH3Pr/hMmS+Vy+ROAWqV7Lj02LU+qZgFplpnLae+wJs1RdijP
         ZDH4PGFtvy6g+AicddU0QNCownRnZLFnLzTL+tBnBwJfmXCvdeKkxjOYS6Hz20Y29yS+
         KxAu2I8+xjKE0FHdGO8tvDWawrhc7q5BYGWF9peEsGtm5N/6UfvhwF99q944s2ok512a
         X8BD7aQqiR1ehwE9DeDhbN6Zt6Vo/nEPRoacfkyp4o+o2b5cMj7Q7TVFOcHpPFsLEXF1
         Q7mZOKpe0wyFYGfg0CI9VfQyD9/yKNsdqp1FsGrsBbxTlpk5vR/TBOvMG8foL2Xwrj6M
         rFCg==
X-Forwarded-Encrypted: i=1; AJvYcCV7cauN66YkTADap40RIt6v1di0WAIifA+LrEDbwcMDrwGukyJiaF35tSVr4YIad/ClnrtUJeTxD2aSpWo=@vger.kernel.org, AJvYcCXiJX0x9zcm2Q5A0YaiiXwP6CGbucC98uQuaPnGLqarwFnZWscVoHyvB0U4b1pPPKsdLMt5a+J24tqi1zCtziE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwb1CqsO6ge319yETvYIuZbizI/kSi24VrlxJOSSMQQ83WOAPc
	P+sr6JaOz0p791k35KcnFxZwT2tAsguzKIddPp7Qpz/4Fwx/xUSx
X-Gm-Gg: ASbGncuNgQ/AN5Du4pgdaJ2U2d859RPe/7QQks2Fiu7xQtPMp3tfs/OskIt9UJuf871
	0Sg+k4BnKb7U44G/XARzfmpIQahQIqzgoW9HmDbzPJvQi+Hd+8RV8fgka7DNrr1T73fNmFrP38Z
	19jtnUANc14aEhZmI7xBvUfJOJrfNaqeNJmmLpb1Ptq5Gn6q16s93MFdac9xPKoE37gUMDLPMsm
	camSW6iNuFFfUa/xK04YNAK2ryBXCrjYDRd/a/vLGkqF4M+4QorEe6WRmyyZRIpus0257GUiONu
	1vIniYzTK8AHJwGEV4gECcfFXnbkpNO3QfD+AobTwnVzCl4kST5bqWvMU/6DH/XeJwNqf+3yd9r
	U028MFRlibSrPuyjM
X-Google-Smtp-Source: AGHT+IHEFPQ7h2hiLqhunzFMCRcCHXQxnJ3HssD/+iXCLwudLrT5IggZ0fY4ywZ4notarqngMnZKOw==
X-Received: by 2002:a05:620a:4506:b0:7c0:a594:d788 with SMTP id af79cd13be357-7c247fcb710mr803662885a.39.1740616915089;
        Wed, 26 Feb 2025 16:41:55 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378dacd0bsm30867385a.90.2025.02.26.16.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 16:41:54 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2034B1200043;
	Wed, 26 Feb 2025 19:41:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 26 Feb 2025 19:41:54 -0500
X-ME-Sender: <xms:0rS_Z-qHnb1z3udMVQg71w3rlADl-5Kx4_8RPFk0ssTNufr-d_7ciQ>
    <xme:0rS_Z8o23cN0gXUZ2OOUMuMaTRzcPghkFhRG61AnERPYIyKgLaFTxO2knPD-_hGk2
    fAUHYTKghkOdxxJ7w>
X-ME-Received: <xmr:0rS_ZzMoAsoL2KIkFvTj6D4vFzQ0ylLSpHKjgwfJiBGIxpyJFqUFoHuzVuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekiedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhgrghhn
    vghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprggtohhurhgsohhtsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepjhhovghlsehjoh
    gvlhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhhuhgssggrrhgusehnvhhi
    ughirgdrtghomhdprhgtphhtthhopegsshhkvghgghhssehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:0rS_Z95b8IAr5V57cIk9vPxV9IQj3u_MqcKTTVBJNWw7vdPYNKZ_ww>
    <xmx:0rS_Z95VzEmi7ly3IrRqhUnzLxp_ZLBZdoNO2UPvbKMm5zNAdsk1gg>
    <xmx:0rS_Z9iftC5GfXLLYP2Hmwtw6OXqfK0Aifr0_r2rXAeY4qo8b83Z8w>
    <xmx:0rS_Z36wQUjk18b5yGAG03hOAAgsgo2ShSyFBlUYQ9YZq6LOOP2Zag>
    <xmx:0rS_Z4ImYsmrxwYVTBU9Ve_ju9CN5hHKmwKJPcFy472NycoJqeSLWsFJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 19:41:53 -0500 (EST)
Date: Wed, 26 Feb 2025 16:41:08 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z7-0pOmWO6r_KeQI@boqun-archlinux>
References: <2f062199-8d69-48a2-baa6-abb755479a16@nvidia.com>
 <Z73rP4secPlUMIoS@cassiopeiae>
 <20250225210228.GA1801922@joelnvbox>
 <20250225225756.GA4959@nvidia.com>
 <Z75WKSRlUVEqpysJ@cassiopeiae>
 <20250226004916.GB4959@nvidia.com>
 <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com>
 <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226234730.GC39591@nvidia.com>

On Wed, Feb 26, 2025 at 07:47:30PM -0400, Jason Gunthorpe wrote:
[...]
> 
> > Other abstractions do consider this though, e.g. the upcoming hrtimer work. [1]
> 
> Does it??? hrtimer uses function pointers. Any time you take a
> function pointer you have to reason about how does the .text lifetime
> work relative to the usage of the function pointer.
> 
> So how does [1] guarentee that the hrtimer C code will not call the
> function pointer after driver remove() completes?
> 
> My rust is aweful, but it looks to me like the timer lifetime is
> linked to the HrTimerHandle lifetime, but nothing seems to hard link
> that to the driver bound, or module lifetime?
> 

So to write a module, normally you need to have a module struct, e.g.

	struct MyModule { ... }

and if a hrtimer is used by MyModule, you can put an HrTimerHandle in
it:

	struct MyModule {
	    ...
	    handle: Option<HrTimerHandle>
	}

, when module unloaded, every field of MyModule will call their drop()
function, and HrTimerHandle's drop() will cancel the hrtimer, so that
the function pointer won't be referenced by hrtimer core.

And if you don't store the HrTimerHandle anywhere, like you drop() it
right after start a hrtimer, it will immediately stop the timer. Does
this make sense?

Regards,
Boqun

> This is what I'm talking about, the design pattern you are trying to
> fix with revocable is *everywhere* in the C APIs, it is very subtle,
> but must be considered. One solution would be to force hrtimer into
> a revocable too.
> 
> And on and on for basically every kernel API that uses function
> pointers.
> 
> This does not seem reasonable to me at all, it certainly isn't better
> than the standard pattern.
> 
> > be) also reflected by the corresponding abstraction. Dropping a
> > MiscDeviceRegistration [2] on module_exit() for instance will ensure that there
> > are no concurrent IOCTLs, just like the corresponding C code.
> 
> The way misc device works you can't unload the module until all the
> FDs are closed and the misc code directly handles races with opening
> new FDs while modules are unloading. It is quite a different scheme
> than discussed in this thread.
> 
> Jason

