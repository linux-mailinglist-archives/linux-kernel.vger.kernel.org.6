Return-Path: <linux-kernel+bounces-515862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC70A369F2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724A8188CB91
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816A16419;
	Sat, 15 Feb 2025 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org header.b="fv/8Nih5"
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24E938DE0;
	Sat, 15 Feb 2025 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.8.165.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739579101; cv=none; b=lplux9rYLZQSrU/T+KyBu5I6NFKeqGXF+FyAtIRJyiYyi9bPLllekjOe64i3htd4ByU7VhYeQTKMYKxNBn8AznOJEf9aKp0pZSC/787RKKqPfrFozQoZbHFtIHsmLuNZ7lzRipeR+/NvndxMvHl+qfSqfDyZqoG6eVWu0VkbMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739579101; c=relaxed/simple;
	bh=jrfcXmzCF8F8brijULRi4AH9cEzhL9Gg1BBF/pr3kmU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TX3WScc5kGJbPXJavFmc9JLvlyi7Yn5NiNnnrGBZWZ9gClUnPbYTWlJ84PBAgQw9VEVP8yWye5C35Wvj5ZoZx8vSdt6MEnGPwokQsStC2CdJAnYUWjU0OJMkg1E9KMoSFifpqP8wadPrJChCy5O9400uEU/4ynGmrDhVHji6h+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cutebit.org; spf=pass smtp.mailfrom=cutebit.org; dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org header.b=fv/8Nih5; arc=none smtp.client-ip=185.8.165.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cutebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cutebit.org
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
	t=1739578604; bh=jrfcXmzCF8F8brijULRi4AH9cEzhL9Gg1BBF/pr3kmU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=fv/8Nih5mKUJpLB13OEhgT4eYP79NSNaxYSjadbJ/WJlQWAeMeBs+RSgTZNrvWjSO
	 m2tg52Mq7vwbzNh1ZA9lgBOW9YuFWUquIRBaWkBaBAUQ/cLaARsHwwaNijw/ywmdMi
	 A/MNcbWNvT+71TiQc1m4rA7sdYGaakuVkTvMmfm0=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH 04/27] ASoC: tas2764: Add control concerning overcurrent
 events
From: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20250215-apple-codec-changes-v1-4-723569b21b19@gmail.com>
Date: Sat, 15 Feb 2025 01:16:34 +0100
Cc: linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB75A9FB-83F9-4E3A-8F7C-44C3CA1368CD@cutebit.org>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
 <20250215-apple-codec-changes-v1-4-723569b21b19@gmail.com>
To: James Calligeros <jcalligeros99@gmail.com>

Hi James,

thanks for your upstreaming efforts. Let me make one request below.

> On 15. 2. 2025, at 1:02, James Calligeros <jcalligeros99@gmail.com> =
wrote:
>=20
> From: Martin Povi=C5=A1er <povik@protonmail.com>

The protonmail address appears here by accident. Please replace with =
povik+lin@cutebit.org to match the signed-off-by.

Martin

> Add control to expose the option of autoretry behavior on overcurrent
> events in the codec.
>=20
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>


