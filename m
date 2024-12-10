Return-Path: <linux-kernel+bounces-439088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 713249EAAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3248D281797
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47A4230D1D;
	Tue, 10 Dec 2024 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S/MyAWQ5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12A230982;
	Tue, 10 Dec 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819306; cv=none; b=fuk0pySjZatwqkjDgPgNQJSbn8BjtmZEjMLhBitnBaL8TDoCxeLwdpUXNHiBjFWVmImkYNAFup1Y/y5BSrcYdk0lur8Itj8SP2PT1AO5MmQJw5O/4juo6ZH9iLYh5Iyscl+KpQzk+SMVIH3VijCdchSmaUj2kF0OqRT4F+RjAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819306; c=relaxed/simple;
	bh=/jKIo/jdjI6FuL8VJks9eSAhySmo5wzdRz7LPNzXfPU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=syUW2NpQ3ZSrdE+3RArLoA6Y5xIfN5z1AtpZ1r+EPdluOusGhbsspammhNZu5Zuh4ClONawb1rDgYhnaT20Z6ac5i6Mwr4dMtBpaUeeTk/5ftGjlfv8uplUF80cEdnQFiD2zqnFP5u6gKKpx0XhJktBgvVEpNk+45BBMXCnUAoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S/MyAWQ5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733819302;
	bh=/jKIo/jdjI6FuL8VJks9eSAhySmo5wzdRz7LPNzXfPU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S/MyAWQ5IcH4Q9duLsVf99Z8tUQsKeY9e80fd0GuoQWMo9wrvj9CwoN2Eqh2TwxX+
	 0vQeOHjK0SmReKjZnK4KXxxZyadUqO8iL9YncDU8k1cnZL+udKIRqpiOgQwhOo3BQE
	 0bzoqBaGJS0npLe/RrqnXVn7+qWd41i5wjHCSjutw4KFCMExx2F71ED2Ve4T+RG5u4
	 N5xZ+cmFHyTZIpQMbWtovUo7sxN4ZfJ+IsKo7HRkU7YkHaAdQ67Regnztz2gOPsG0R
	 wErvZkCxNXolmh7WSHjs29a+TlgowcEKUwWWgRptaWh9ToqArVVL7EiPO0NVpJNiGy
	 W8t6XU3J49MjA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7AE6017E1522;
	Tue, 10 Dec 2024 09:28:22 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Fei Shao <fshao@chromium.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20241124085739.290556-1-fshao@chromium.org>
References: <20241124085739.290556-1-fshao@chromium.org>
Subject: Re: [PATCH v3 0/2] Add device tree for MT8188-based Chromebook
 "Ciri"
Message-Id: <173381930242.18469.18254539260828193661.b4-ty@collabora.com>
Date: Tue, 10 Dec 2024 09:28:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sun, 24 Nov 2024 16:52:36 +0800, Fei Shao wrote:
> This is the v3 series to introduce the device trees for Ciri. Please
> refer to [v1] and [v2] cover letter for the detail introduction of Ciri
> if needed.
> 
> Note that there are patches for some known dtbs_check warnings:
> - sound: Unevaluated 'mediatek,adsp' property
>   https://lore.kernel.org/all/20241105091246.3944946-1-fshao@chromium.org/
> 
> [...]

Applied to v6.13-next/dts64, thanks!

[1/2] dt-bindings: arm: mediatek: Add MT8188 Lenovo Chromebook Duet (11", 9)
      commit: 3a11be8938aa7294719c0cf2a4758ed0cf88ab84
[2/2] arm64: dts: mediatek: Introduce MT8188 Geralt platform based Ciri
      commit: 5e6af7f5418950d77eb2193ddfb8557458a070b0

Cheers,
Angelo



