Return-Path: <linux-kernel+bounces-252299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1436993112F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A685CB21434
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038BE186E34;
	Mon, 15 Jul 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WBX+mQ63"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C4186E27
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035756; cv=none; b=LfGy+/LqcsbB6EPoS4G7PmwRLlSkj+4Wz1pDvFjgYeR9oDOtkkw0MtMSmcQds6wSGbY4QesSxIrAUmlgWNII7tS092LOBKN9AfnqPFmx385xrmmCk5t/39RllzwdyVPN6CVU7XotFcegMj1zWejFmf9YTR/OY6qu4XoqWqToz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035756; c=relaxed/simple;
	bh=HaJbKi7eEpF0XyWb4QDH6uBVZM3D75uNBRBp4Tx+M/A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meWpX7uw43dL66TA/VlLlhb8jKjd4gwOOz4OggVMMtF4CgKQ1WNdDo2IFBDyWRPQ/LDDunXR+fZokFiF1e8Wcr18gGDSWmp2fJJqSoo7q5ToatGYir9rt682bGMK0Gc/BmY95D2VpFXFZK3SU7f620Foxs6syigmHGFpOh9Cra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WBX+mQ63; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721035745; x=1721294945;
	bh=HaJbKi7eEpF0XyWb4QDH6uBVZM3D75uNBRBp4Tx+M/A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WBX+mQ63/i6O3wUPk19BqM2RBdX+5r3FCd2AN0r8xnMJSQxRydSMZJ3j6tn2txjLj
	 pX4NDsqcn8d3pEf4xjgSypKrktg3oG0nv0jsSsgB/azjZ1YK7eHDzT9wMv5QZx2VrB
	 igJXNqFyz6kHvH0buZh86XynWpmZmFB5kdrF+KSpz/UCiQ27ofHdq0uWxdgsoWjv6o
	 5QaLGnO93Tq3ZsGW534/uOJ6fzsfvyiSC98hla/L7uKKX2Q4MTxlKRiPPrygXuVK5k
	 0GUAgugoYpGCzF0PJBDxsoH8qxZkIjbPCHMLH0XPDJStJomfwy9aIvN/1R44KL2bSI
	 6QOkEvTVw1FxQ==
Date: Mon, 15 Jul 2024 09:29:00 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
From: Tj <tj.iam.tj@proton.me>
Cc: Marek Olsak <Marek.Olsak@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "1075713@bugs.debian.org" <1075713@bugs.debian.org>
Subject: Re: Regression: firmware/sysfb.c device path
Message-ID: <qRNIostAxg5303tUSChdxUG3k53ylqvB-EoPEFUnz6avhPGHXWKOznFRckJhDJCDjr65ptNRF87AIUqNzMH6eIp2QfL46HTtkMSxHjfo_l8=@proton.me>
In-Reply-To: <a01f6a7e-c56e-4a78-8605-ab5b253d9c9e@suse.de>
References: <lLyvPFC_APGHNfyGNHRpQy5izBikkaTPOpHooZIT3fFAoJPquSI31ZMueA99XTdr8ysir3X7O7IMdc6za-0m79vr_claeparHhoRouVgHOI=@proton.me> <1eb659d8-536e-401b-a427-19709a98953a@suse.de> <-sJINpD9sbYc288gXp2-Tf5w6diSusXAP8mM8l0mnLWfIXgjuNe1LBgkqQ2indMJOehVrPUPO3UMQ-AvObgCWUW9h_TepvcNy9gnqfvoyvM=@proton.me> <a01f6a7e-c56e-4a78-8605-ab5b253d9c9e@suse.de>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 050541eb227a30cea367765e6a546942ab4b8ff1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, 15 July 2024 at 10:22, Thomas Zimmermann <tzimmermann@suse.de> w=
rote:


> We should definitely get your patch into the Xorg upstream.

Working on that now.

