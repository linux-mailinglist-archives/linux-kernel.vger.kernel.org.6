Return-Path: <linux-kernel+bounces-540285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634BA4AFB8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5EA7A94A7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6921FC7F7;
	Sun,  2 Mar 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="QaxbZdIC"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2111D63F0
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897872; cv=none; b=BNRcyLzLbAVyK+YTPRR0FCoVwtwdQqGU71lzPzoLPvqC1F38nVhJH7u1F4d7l6GyGYzVFw5OWILGi30oe/qJkCdCMD3PdNUVDWfE6UupgKGZyx7l2gYM8A1OcW92drA8llswzqxb31UVQTJdi6VCsZf2nayRb9awySEak9RPYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897872; c=relaxed/simple;
	bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=qZXbccdQgzu8FzX7I67h9gxDM9tlKJ/kEP1VIwP7irJyxsF+ZKrYclPfrtyajrwNg0lT6+z23b1K4IRCGU8jUeMve+eU/pA7E4W9Xje5/BPvtz3vob76pfeVGPHiknbjIKoa0sbCdCh8j1g0xnQlJFX92Br3NYM/W4Ma4R4K04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=QaxbZdIC; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=; b=QaxbZdI
	CdMFSEOfLpUd5yKTka1j1S2NedRXVuvwCV+8ZLKm3IWAmtslSC/zvUDX6YW/ZqIK
	TsBAD4zRBR7d1UzSERHQxeeh2k+d6cX75//wBS+2NoDFTspE+uXd0LCSghQPbdFC
	7u5ZSJy1yKwGQyzd2ElpMuzLt2+oa1FYpIh8=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDHjyVH_sNn68FZBg--.50517S2;
	Sun, 02 Mar 2025 14:44:23 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Swift
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wDHjyVH_sNn68FZBg--.50517S2
Message-Id:<67C3FE47.06C8D5.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUg_cfUUUUU
Date: Sun, 2 Mar 2025 14:44:23 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgcEumfD7Anz9wAAsG

Hello! Rust is better than Swift


