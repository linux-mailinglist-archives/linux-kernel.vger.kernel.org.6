Return-Path: <linux-kernel+bounces-261079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A6C93B2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230A51C23821
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC61159209;
	Wed, 24 Jul 2024 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="DfALEQLG"
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15012D030
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831207; cv=none; b=Ne0cwX7pdkuDh95UsHgsh/GYKa3gK1LEZf2mQ0DtkivKsg/KdAo5EgHXx4+XDDYziFIwfDFjoI3Qbih5spPnSULrDgJyZuNcTKGlAzdUkAoJfi0Qi1IPWDLj5ySk+JrqhH8hw98kGeZcwReR2Pxqe17s8yPASRW9Kxq0OWwrH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831207; c=relaxed/simple;
	bh=KYcJcqRVk3mS97aSzfbewxC6lJH90M5EAEV9mj0wF+U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVO5RKsLXaomvUX1mfspSQ3++6QvxDDd0XXiEHp1X3S3wgBVmCYIhoQ4efFahnt6Vzmg9crqzHhF6PjNsysL5f9pBCwJNSqf62AmPm85RXOmBoij8H8HI8X4QQKFkO6rDvGIbcMZ3ukPNNj0g7Apx7pNg5Kr1G14u43RTKqavok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=DfALEQLG; arc=none smtp.client-ip=185.70.40.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721831198; x=1722090398;
	bh=KYcJcqRVk3mS97aSzfbewxC6lJH90M5EAEV9mj0wF+U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DfALEQLGmcQ+v5GborG/evXLraqw7jsC6DgA/DGgVRBP2vcWHfxaHj1To6ORiVw/K
	 zIqosc8qxqlz/LRtOt1DYbw1rCsq1VuzjOP5WiQqjPWT8ino4x5bM/r41fy3jj8Jje
	 Z68fBJHi+xTBGCY5UY5sJlyze9fNmrRPFdXs+f43rzcSg377HbiRPVOzGpNzeTUpJQ
	 VDPiVNikiLGPQNmAM6/7ZLIztnQq5lrFvng3vAg4ussyJIahtkjpia2E7CyndFLI9G
	 GOrnFbRo8zAK9aIwADWaV97F+7/TluRZLZrSEIdxgezeIkePcBpurGJcPzOWmcrRmU
	 pMRrJdMM7GplA==
Date: Wed, 24 Jul 2024 14:26:32 +0000
To: konrad.dybcio@linaro.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, nikita@trvn.ru, phone-devel@vger.kernel.org, raymondhackley@protonmail.com, robh+dt@kernel.org, stephan@gerhold.net, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-fortuna: Enable the touchkeys
Message-ID: <20240724142613.3395-1-raymondhackley@protonmail.com>
In-Reply-To: <a1c12920-4217-4898-b23a-1ee8d91b5961@linaro.org>
References: <20240723131142.1703-1-raymondhackley@protonmail.com> <c5f8cd32-d5c5-4c29-be8b-571804a4b088@linaro.org> <20240723133916.1947-1-raymondhackley@protonmail.com> <a1c12920-4217-4898-b23a-1ee8d91b5961@linaro.org>
Feedback-ID: 49437091:user:proton
X-Pm-Message-ID: 4a287cd43a3e6b0668a43bee679b8d01638d3f22
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> See the "In case your patch fixes a bug.." paragraph in:
>
> https://docs.kernel.org/process/submitting-patches.html

Hi Konrad,

the point is not to fix a bug, but to add touchkeys support instead.
I will reword the patch when it's confusing.

Regards,
Raymond


