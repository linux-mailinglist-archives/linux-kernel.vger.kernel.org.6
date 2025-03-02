Return-Path: <linux-kernel+bounces-540349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D40AA4B000
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A42165757
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D249F20C038;
	Sun,  2 Mar 2025 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="lMeg6FFM"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDD81EB5F7
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898740; cv=none; b=kNsgpFJ6US1PijZBxfRckLH3zSFiUXf+mVR/oVSw6rAJi1R3zzvW6MaOfJhEA6RCDuYLCzWeeb5ZI/kiq5Jo3+yT4ZnZz0GozP1jSfcLntmVvmsR1PSf9rP3HN++5FUXryzN+CHHrNZmq7oXTU8a9IyuWaKKtCDhwNLTCoSCZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898740; c=relaxed/simple;
	bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=osfgt88O3yqspyDtJa6XeDs4pf4U26yJlfUIOFi4MPXxVtQsz4hiBwUVluQC50aI4pJiSqLvKv7neLmJByLWDyO1L/9pl3TCJCkXN1+0zRNlRrqfDPewcS2JW19JLrpzNqgXsFbiNzBekiLoX1xr4ijwQrFB7wQsNlVaX3QitP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=lMeg6FFM; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=; b=lMeg6FF
	MASG52r3ZcHTtT19rZyKfsUmL8LUE2eR/DFS3hwAVVHKnVIG8O5DyKkobqNr2v9/
	0YTZpmjjxCJ0D/wIGk6pHT7a9p7fg99EC5WKV30DKa/lYXl1skMEn4j9Bu6Q6E2I
	liWMAjKyuWHhaxbAIzVX+HkiZTGm0aPVISuc=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnP0Qf_sNnpPaxBg--.56589S2;
	Sun, 02 Mar 2025 14:43:43 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Typescript
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wDnP0Qf_sNnpPaxBg--.56589S2
Message-Id:<67C3FE1F.071813.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUToUqUUUUU
Date: Sun, 2 Mar 2025 14:58:55 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihcEumfD7fHXdgAAs6

Hello! Rust is better than Typescript


