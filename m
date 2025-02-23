Return-Path: <linux-kernel+bounces-527542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C27A40C7B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C717017DC35
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E7FBA42;
	Sun, 23 Feb 2025 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Vx+OKc8d"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52B171C9;
	Sun, 23 Feb 2025 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740273632; cv=none; b=LopmEaenxlgDKF8MhPaQKEWpKK9Hmlu5lRIl7zSV0YpXz3n2oYS1VIcnyNSPZURJyDRe5y67eumlaV6pDtAM3JhNNRWM5DCxCJBC28gRha37I3UDBK1/hxziw5mMK24j1RfRgjTI5CNuLdZ9HF2WHyiCJABuEH/h3GzvY71P1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740273632; c=relaxed/simple;
	bh=x219kO9/TY6esmGdDOm2ZSMAJh5cKoy0bTXUTRMdpi0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=jrMqQjvg73hzy04IQ6eJx1NWpHK9pd6jZLlBvz0VtPYc/YzC4juyUwozfGnpm/YOOHuRUz89ee7mpLVm3nxPtTT4j3R/Gg/BSiaKKvJF2VYMlRvfwg2gSvjr6kxmSM+C2b4X2woEtEh3WIvQXH/bNiQeoTNnGdtoTar2Uv6JAoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Vx+OKc8d; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7C9A725BD1;
	Sun, 23 Feb 2025 02:20:27 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n66v7EwL05kj; Sun, 23 Feb 2025 02:20:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740273623; bh=x219kO9/TY6esmGdDOm2ZSMAJh5cKoy0bTXUTRMdpi0=;
	h=Date:From:Subject:To:Cc;
	b=Vx+OKc8dTwitGMgNarf5gOllSDkihJeUlTgc3HO/QKGcsNXRrS04qi96TZGFVyT93
	 14y9TgCkMxyLrC/SO5gxq1nY/Q27ijzQbk9ciM87nWuj9TPXIoIsWUAY1Ag70ogI9f
	 SEfhiLoM8y+xV9Jec9/69NM1DuuB1+2PGRqmhQP47wg3uJezPxfptUbzXxcnliVpUa
	 FWoI4x+8Cye7GAaZbhcCFYaYpWUs8SnXImgwLL4AsKUj0rnuaN6N1b4jh7hsZFilI8
	 5cca66mjpsMcBOuQ18bvtSJR3Brs9FOihnEqIK1u6+aXlvKNTsHNifAfEz9xkH8r99
	 /1qrY94yOYx0g==
Message-ID: <bfd2258b-9bbe-42e6-89aa-1bd77a58983b@disroot.org>
Date: Sun, 23 Feb 2025 02:20:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: NoisyCoil <noisycoil@disroot.org>
Subject: Please backport "drm: select DRM_KMS_HELPER from
 DRM_GEM_SHMEM_HELPER" to 6.13.x
To: stable@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

The build (actually, linking) failure described in [1] affects current 
stable (6.13.4). Could the commit that fixes it in mainline, namely, 
c40ca9ef7c5c9bbb0d2f7774c87417cc4f1713bf ("drm: select DRM_KMS_HELPER 
from DRM_GEM_SHMEM_HELPER") be backported to 6.13.x, please?

Thank you.


[1] 
https://lore.kernel.org/all/20250121-greedy-flounder-of-abundance-4d2ee8-mkl@pengutronix.de/

