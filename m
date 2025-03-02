Return-Path: <linux-kernel+bounces-540281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41DDA4AFB7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3124D169C48
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E931FC115;
	Sun,  2 Mar 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="e+nHV1Ci"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2321D7E37
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897872; cv=none; b=klnBj2hiWj+s4j+WR64HcpvuQdB8CmvCfiVIeAHmjwX59T7Mwfpum2QCXEc6gbbG6Ut5GCiAMINWg0TiqRVHQx2zZRucRMzxz0XuzWg6EzYiBcZ+80y5oJJkHyavYBCrORKnMWTQE/rt/kqzqRgAzOrSZPU/vShKlM9XvX6uCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897872; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=eR5JWmJQiDKzlOfnDjoG7XD/12JmoeE/+vMvJGo2VrFxnwJABOGrsHj7/tdFskZCpKbCLlOOGUvKFspQJSRZ3TmyBTfWU+lQqRTopMawKUXWaIV7sVC4s173DnuVlJDd648nR5ioYyYRwb/QgbmqkYXKX6DHDKqUX6BcjHOyPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=e+nHV1Ci; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=e+nHV1C
	iILcJD9x4h8d05evh9a1UKWSL3GEtuLZuToDBLkWpECql+asDgpn5WKO8OROtaIz
	dxfabXghfVFG3IblkiPBszoC2fhvbS1Cm8dfqfMSXjJA0OeK8XXe5aI3aJWJSx0k
	WJ/ziEcAr/8WuvMMeYzSnUPN+ZYAwoQcbwZ8=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgD3X5FH_sNnZkhhBQ--.2102S2;
	Sun, 02 Mar 2025 14:44:23 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than PHP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PSkvCgD3X5FH_sNnZkhhBQ--.2102S2
Message-Id:<67C3FE47.0B5A76.19577@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUg_cfUUUUU
Date: Sun, 2 Mar 2025 14:44:23 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgUEumfD7An0AwAAs3

Hello! Rust is better than PHP


