Return-Path: <linux-kernel+bounces-265732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AE093F551
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6515C1C21CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705841482EA;
	Mon, 29 Jul 2024 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="Z/Hta7Hn"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51513CFA5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256004; cv=none; b=Gjbt5EdEhc7a64XHS52Fd5mwyzVP0qYYa60Vg6j6TlZW/Hj8bXa27kc3a1/8ns3igyPh/2u3sezy4XgPJkKrrezo/PXc/ihgQk/rx6HcpAZ0N+DRj88lHZqdxeg70cubEILd94NcQGgC9Sj2IrN/UuMTTkDM6HJSkTjAhO2EhGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256004; c=relaxed/simple;
	bh=tnmIOvif+vMuCBE3EGoaZf2hukzKj22SPXaah5owu8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IguF9nTsbKdkQB5jSrWtZdyCgqXwpdz/1IsHp0YfoqPC3vJIoZOme5kO30UitDp1tHLPZs0RMEqJ45+22N0Tha/EzGaYqFjIgvDfjYECjTaAFXaV0M2BP27g8B0A89wdJcB+hVwH8Njy4wfS1cudM2xlNczsCTY8//7wP6W4Da4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=Z/Hta7Hn; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1722255448; bh=tnmIOvif+vMuCBE3EGoaZf2hukzKj22SPXaah5owu8g=;
	h=From:To:Cc:Subject:Date:From;
	b=Z/Hta7HnbeNlSgYg1U4xfiqxC37/5xnAxHzZWqKx03esDN3CzvP3UzwZbLRduPvpT
	 SFqMudQDAhb5QhZobjp8Z7TzWqBtbZlsWBgPs7xLegENZyHvNXiX6BLnj3chsZww5j
	 7MQ+oNTvoWWMAkUbecnd1rDe/MrEjaBAi5k1KbqGvsRW6qmPfGPKx9p5OsrAJibOui
	 JajHetZU5aXIzBWGMSAU1e8jsYj8HGCqKl2qxFXMF2mWYDqlkK8pTpjGG7Xyb1t3KV
	 NGw9xHfwPHkOhAhFx4p5R4xpHwvCu16XZ+4VdxR1gPwcHk4/uEFFfXi2YssckrY2Yy
	 v9D/LrQa+D45Q==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 46TCHIZr540506;
	Mon, 29 Jul 2024 15:17:18 +0300
From: Ofir Bitton <obitton@habana.ai>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        sfr@canb.auug.org.au
Cc: jgg@nvidia.com, yaron.avizrat@intel.com
Subject: [PATCH 0/1] Update on habanalabs maintainer status
Date: Mon, 29 Jul 2024 15:17:17 +0300
Message-Id: <20240729121718.540489-1-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dave, Sima.

As I am about to leave Intel during the next weeks, I'm stepping
down from the maintainer role of the habanalabs driver.

Yaron Avizrat from Intel will replace me as the new maintainer.

Ofir Bitton (1):
  MAINTAINERS: Change habanalabs maintainer

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.34.1


