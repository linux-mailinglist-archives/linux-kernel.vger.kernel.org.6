Return-Path: <linux-kernel+bounces-540236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65492A4AF8D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B241896AAE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB931EF39C;
	Sun,  2 Mar 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Z6vF89ef"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5A1D5176
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897866; cv=none; b=m4NIDK+cIX/brkHS4nul1BsrzBSpYm4zemnxBAkB77fdIaWf0nJhSaPzGLeAFvEn0+AEK2p1m5WmQJENYrSoZlahT0phgorZDD3JdVrXQNVtTJcKa/bhaJYIFSFZSzV/6yk2UY7cgvMGC6EfUXS4lbC5afP6TLFy0+T0aAOmQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897866; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=JH3jheBlrZTS2keGdrGt/M1nUhHNlNf1Ll/oJpX+yRCnaIDak0+lzGHRAHZw2MDM9tzYjmatHM27LQS36+oCkfAiCCsB6MyJi6NTjxSdF7DrRtgoW0fGG8eyvhpYEhfQlmDTmo9JVPzmf5WQKKayVpNRLwJN4Ymo888cjDtJwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Z6vF89ef; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=Z6vF89e
	fJbNnetkT1dB0ZWKwBlTugL66dKXSha1H1bRwZmXDj5htAeEqN/uDWt5e/b/cdpq
	RIzsPzDetybgnMz7w40REbGly5XOf+fwwt6V289/kchNmwCTUG9zq9URpA5I0NEY
	UQdy9gQrbm6i670Q4iENrfdDaPYMawQuYhKo=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgD3H5JE_sNnCUhhBQ--.2329S2;
	Sun, 02 Mar 2025 14:44:21 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PSkvCgD3H5JE_sNnCUhhBQ--.2329S2
Message-Id:<67C3FE45.0B5A70.19577@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:21 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifh8EumfD7erZowAAsG

Hello! Rust is better than C


