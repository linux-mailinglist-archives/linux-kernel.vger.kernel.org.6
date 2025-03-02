Return-Path: <linux-kernel+bounces-540337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BACBA4B00D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2610D3B916E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A03A20A5C9;
	Sun,  2 Mar 2025 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kqkBvhxU"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B961EA7C2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898739; cv=none; b=O9EBaG7k+dg/hrXaavtnAGZNHOPgt1I4iw0URV7yoDQESk6Eze15KqxxRBKltLYW6O6d3zWRme/Px05Lb9JupTleV1HagiC/+mCCA9Devr66zoXhqdWKbkxmgjbF2U5mATG7TzhtPdZLXEAlrK60acE8QiwizagidOzEdPsucRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898739; c=relaxed/simple;
	bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=tzocWR1Key+tb5mCBFp00B1RIMIs5RmbCm/GRl5MDnCJL35D/mfQ+6CP8Qfn+Oc+ucLbf1r+6xa/x3VRAYnLkN8nm7PRU6nfAoOR5FJ8ltHa8v6MLVZ70YvtR/EEUvysaD03Hl2p4vjj3ZdSsVDwrpJ6XcGoFvZ/Sb1/9Y5F1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=kqkBvhxU; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=; b=kqkBvhx
	Ue9Vq33Sfso1m0QOsZWbqFYZFmdZZEiDoapCqCr0aVKdy7qHRtiDxlpWPm5G2lhh
	DRAe0GEYws7nE0pKTWzAS3iM8GNgBqBaO0fmWmFv7bjnoJwlXtpVG+7iJpCGG+T1
	gbERDPubwYom/pHu8cub43O7CfOyugDzZbv0=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgC397Qg_sNnnUJhBQ--.7218S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
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
X-CM-TRANSID:PSkvCgC397Qg_sNnnUJhBQ--.7218S2
Message-Id:<67C3FE20.0B5A64.19577@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUToUqUUUUU
Date: Sun, 2 Mar 2025 14:58:54 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOh4EumfD7AnxyAAAsi

Hello! Rust is better than Swift


