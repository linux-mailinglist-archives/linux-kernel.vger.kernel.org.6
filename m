Return-Path: <linux-kernel+bounces-362517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F163499B5DA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E98C284079
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1100C19BA6;
	Sat, 12 Oct 2024 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab/dtrO1"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27CE17C7C;
	Sat, 12 Oct 2024 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728746382; cv=none; b=JCSCd8xHcmXMRQ3Mxc5Yu3SNpMl26j+XPizDItXVUw16/AQaApdeAJvZr6KFIKVYME8pX/CVyj2QxwO69sooRyuQWH1lw0Oa4BoQaizRg+Hvpz88qEojtaCaw8F0FojUH05bfg4kJBRJHg/gEfcYX+/SRkYEl5Z6DEtFe8Vl2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728746382; c=relaxed/simple;
	bh=eGkwhL0l5q9yqTx+ZgKNcSYaKQAZm2uAzS3eFuTFyh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh8zhPX+RgyMCWKOL2FRNxHu8t2lr6yvgNnoi60Isx8VPEImgG8kOBojrpRxw1b+3jBKJuWf7VxmH+E6cdon11ajfyRt9ekGFtkeMl/HEuhSt0yIheZ6EMDCqnFf4s2GAp5cqv1QPyz8MRCcpUMJM+l7n/t1vSHbZczi06Qiehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab/dtrO1; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbd00dd21cso18890226d6.3;
        Sat, 12 Oct 2024 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728746380; x=1729351180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2hqgHp74vp//VMe7oyr+jtqdRDjoaMSJXEykJ5GF+E=;
        b=Ab/dtrO1z/n8b5edETx2QktfMISAjYDapJVMkB7LTrM8z1x29AwXmdP/q3pnCUn84d
         XmH/jVAq8TdEpHAM2WIZI9PsBpkiMkCkZHYYWmCfLO/1aTsPSISCC3sL/ZuO+GbIlcrz
         D39xcJtd+cumRD8K0lAcwUX6MOuSfDO+ky4VE8m/kDfrYTTEQrdkas4C7SQwO7cjTbel
         Uou71vXNBngePD4ymnEzJSMD4+gb9C+l8LiRbgwTVuzdTW4+6dNBGDuoAq0Ex7Fe5xu5
         VYR1oOLHNVhMzc4HIOgYqLqg1MebwwLHYj1ehDSyYB8FxRe8VkEQgQ/T9RE3iQoaXn4n
         x47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728746380; x=1729351180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2hqgHp74vp//VMe7oyr+jtqdRDjoaMSJXEykJ5GF+E=;
        b=SJMuZANiWO9/LEVLaI4GltqpXw6pduS/6Im0wd/6ielwvivA4fhkrMx8PbrpYnN96T
         vAeTQzXUYXsEXbtE0jRhIjYb8vtxL7uoW6ADJDpe90p4uYe1JqHUGa26zW7gD1uZjsQ8
         K1O1hnB2SkxcDDsiEW+h+5qNzbSwG92EyF5jhsEYNXoK/Xu6irdIfMUHrmZQip7t2Dmg
         RJRNuzpgO+t5ASFHU/V7MVJCN+4/odG3upi8DwHZfMdwXnV3RBpGXxaF4Ti4qtPT3FAY
         NOzMsNaXzacvW3CRuum+E2SOOyiG0yytvYOEOPMqfKpt3aHaALC7etWkB70e+0i2IKqc
         F/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg0CcKveweIvm02dGFj4vQU/FXKy8cc5fQRcKcs6WLY27ePVt/XmjT3QP5SWulENBF98YF6XWOoqAgfL41a74=@vger.kernel.org, AJvYcCWRVxiWcAJ8P6fdCFeYSC/HBM3o76hQm7O5XI8lSgkxF0HO6HHv2ZNxU8S2Ky/WAX1BfE8K3W4AK6qP6u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvawgWG45PB3AuvbDOBzFzEBF66qrbaOKax0JR9lv9SINiGJT
	SmF1wVDt8lZOQhD9JyM3I/eYQzMKemsErkbYT/TWUc+2IOiVxooZ
X-Google-Smtp-Source: AGHT+IFuEO2D0JUQ+li+8xP4eefbEmNshsf1ZWYrqiMQDWwBHmwz9rkP9AAUdMfj2bo4nf9gIK6B8w==
X-Received: by 2002:a05:6214:3198:b0:6cb:3b34:55d3 with SMTP id 6a1803df08f44-6cbf00890f6mr92736546d6.29.1728746379820;
        Sat, 12 Oct 2024 08:19:39 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe867a9c6sm25686986d6.144.2024.10.12.08.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 08:19:39 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6A11B120006C;
	Sat, 12 Oct 2024 11:19:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 12 Oct 2024 11:19:38 -0400
X-ME-Sender: <xms:ipMKZ30YgWrQJ-qseQoCM36rsPVXsz0CoqcVH1RckKGyudtrzK8xBA>
    <xme:ipMKZ2HXKZaCYtfC4nlDxOav7Fudk1KynLSKsxJmU1S_vS9A7s4rxQ2cUbK4wQsX5
    RqZfIhvG_phU5SKQg>
X-ME-Received: <xmr:ipMKZ34yHioZvdi0_KJO-77K2pQ0bHY_-cUlWz1J_aX6Ednirt9dr7JKoAidxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeguddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeejteffieehudffvdejtddugeefvdeftdekgfeg
    tddutddtkeefleeihfekteefieenucffohhmrghinheprhhushhtqdhfohhrqdhlihhnuh
    igrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonh
    grlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghnghep
    pehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudefpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhhn
    rgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggvrh
    hitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhi
    gidruggvpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoh
    epsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggv
    nhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:ipMKZ80fRCXFT2uXK4-a9m4YuDcUHEbHUTXwClWwEZWTTYCjD0wgMw>
    <xmx:ipMKZ6F802UQ2KNWwzOU61JPf4tjsr-3506dOiwK6pQg0_AyYlLx_g>
    <xmx:ipMKZ99SV2Bq7RrIxtty347GzNXKPNJGHrSaiIerZQAmNO-3Re0qRQ>
    <xmx:ipMKZ3k01LNGBKqH23DCaU6tJFK_tyIoHD2O14qqFYDbkkhHi7nJHg>
    <xmx:ipMKZ2Hau46vLCEiPerDlrd1cQmOJXmxr27UvFixOMj_URwifPq1Z63o>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 11:19:37 -0400 (EDT)
Date: Sat, 12 Oct 2024 08:19:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] rust: hrtimer: add maintainer entry
Message-ID: <ZwqTf-6xaASnIn9l@boqun-archlinux>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <20240917222739.1298275-15-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917222739.1298275-15-a.hindborg@kernel.org>

On Wed, Sep 18, 2024 at 12:27:38AM +0200, Andreas Hindborg wrote:
> Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Also
> add Boqun Feng as reviewer.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Although, I would like to suggest we move hrtimer under
rust/kernel/time.

Regards,
Boqun

> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc40a9d9b8cd..018847269dd3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10035,6 +10035,16 @@ F:	kernel/time/timer_list.c
>  F:	kernel/time/timer_migration.*
>  F:	tools/testing/selftests/timers/
>  
> +HIGH-RESOLUTION TIMERS [RUST]
> +M:	Andreas Hindborg <a.hindborg@kernel.org>
> +R:	Boqun Feng <boqun.feng@gmail.com>
> +L:	rust-for-linux@vger.kernel.org
> +S:	Supported
> +W:	https://rust-for-linux.com
> +B:	https://github.com/Rust-for-Linux/linux/issues
> +F:	rust/kernel/hrtimer.rs
> +F:	rust/kernel/hrtimer/
> +
>  HIGH-SPEED SCC DRIVER FOR AX.25
>  L:	linux-hams@vger.kernel.org
>  S:	Orphan
> -- 
> 2.46.0
> 
> 
> 

