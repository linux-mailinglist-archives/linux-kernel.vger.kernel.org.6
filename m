Return-Path: <linux-kernel+bounces-540405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6025A4B03C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0462888599A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A1253345;
	Sun,  2 Mar 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hC+OI8L6"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264381EE02F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898748; cv=none; b=OHDjCnYXGgFH9GbDRqtGoxRO4PUlV/X1pV3nXdU7DYKmS8Ly/felAmDwrTm96ZxY4g3k5RTzEphqmGSd/HKv7beVAA/kEatXCNh01DiZ7SsjESjpzPKQCG1fGVnguI12/2efc1W0IhDJXrp1aG92m/Sbz4ipvpeYlPvMypXqHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898748; c=relaxed/simple;
	bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=Oz8hxdC+bVjSM5A4oHaD94LWlclHgRk8hWrm6JNRNwvEcTlWGUXHomuCrNUQx8CQykDC4GRLlSQIBZm1La92QIBFy4av1IqDSHaKAtbmAndvn0+c6da/Tky05BzUPk4RK6irf6Ceu0DTaXsoOCxtIIwWRyGqBFl/BswYsjyIdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hC+OI8L6; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=kuanHuw9J0++yX2NZUc3mDyVR4V4BIDbLbg7VpSpL+4=; b=hC+OI8L
	6rUoMMgsQ66VFAVybhXtu1AnQ5tDUCW8qVYInCooZmEblRUvnGsA3k1LcOZG+mwo
	TqW3Hyf0ToXUbJgliTMoZ9KaSxinSVibH+w1vHNqv827/e7xrsQHprOUxh9xLFqQ
	wBWs9Ez1bzS5X3Bl7syJwHwODhQ9fsT57ZYo=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDXn2Ye_sNn1x0JBg--.59925S2;
	Sun, 02 Mar 2025 14:43:42 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Cuda
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PykvCgDXn2Ye_sNn1x0JBg--.59925S2
Message-Id:<67C3FE1E.0D9042.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaRpBUUUUU
Date: Sun, 2 Mar 2025 14:58:56 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOg4EumfD7AnxrAAAsW

Hello! Rust is better than Cuda


