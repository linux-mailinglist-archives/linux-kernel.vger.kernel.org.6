Return-Path: <linux-kernel+bounces-372690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484299A4BE7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 09:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F95B21F74
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A161DD0DE;
	Sat, 19 Oct 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b="1ypJ/Wvd"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F313C8E2;
	Sat, 19 Oct 2024 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729324006; cv=none; b=bx6+B/V1F04uuRxVVJNZDylGaNgBSuUdXY39PlmTADQny2sjXcjGvhiov8zOQNlNJqTnB3L4w3WMjW4ZGFhb4rjNfMxa/+MLHmksnCi19MKtwNFU86eVPtWCN5dYQ8UxCY/89a0EFknBT/t4ejnFcGml//CsNxs44vleH5TS0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729324006; c=relaxed/simple;
	bh=M/QX/lS6xRABHzsJFCN2mnwAkudqf4WZN4eEakuqqVs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Wzq6T8C3mvWFEiV64UmxpDOJvRpZypehBHVAAeYWonmo8jwUin1q6HSI8kmw0UZIqq0Pyjw6N5wECmj0XoPKvckrG4g6ApWZ1Qb+hR2etZOz06jKfosohD5qtOEU4xRJN/rltixS2iQvpS3ANp1ovtELl7X8X6QwGIFWaFjnwYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de; spf=pass smtp.mailfrom=wiredspace.de; dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b=1ypJ/Wvd; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiredspace.de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiredspace.de;
	s=key1; t=1729324002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/QX/lS6xRABHzsJFCN2mnwAkudqf4WZN4eEakuqqVs=;
	b=1ypJ/WvdK7goCa5xjq7zVTXZq4tklKOTOjtfNdORugecDz1IKja1XnRjuqPaWhmAmr8P/0
	VbYOOMEJQRalQFK+f6DL/3JGoYZUaWrqSF0H9Fw1UuPAI8WFGuPYYp7WDMCnR9u1AUYi6v
	7nICfbwQURqbDLqM+5H3BGNMWaucgiE=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Oct 2024 09:46:39 +0200
Message-Id: <D4ZM720DHP6L.3JT8TO5FP71XU@wiredspace.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?utf-8?q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
To: "Jocelyn Falempe" <jfalempe@redhat.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] drm/panic: avoid reimplementing Iterator::find
References: <20241012075312.16342-1-witcher@wiredspace.de>
 <CANiq72kG0Ai2DHfERD0aPDVuEpLYrZ_2uYdw17=eeHRp+2Q1Rg@mail.gmail.com>
 <cfde8e06-0931-4a53-bae5-469219e77b49@redhat.com>
In-Reply-To: <cfde8e06-0931-4a53-bae5-469219e77b49@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Mon Oct 14, 2024 at 11:06 AM CEST, Jocelyn Falempe wrote:
> Hi Thomas,

Hi Jocelyn,

> If you want to send a v2, the easiest way is to download the mbox series=
=20
> from https://patchwork.freedesktop.org/series/139924/
> and apply it with git am.
>
> That way you will have my reviewed-by automatically added.

That's neat to know, thank you! That makes the use-case of patchwork a
bit clearer for me.

> Best regards,
>
> --
>
> Jocelyn

Kind regards,

--=20
Thomas B=C3=B6hler
https://wiredspace.de


