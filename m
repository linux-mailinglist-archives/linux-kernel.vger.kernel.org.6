Return-Path: <linux-kernel+bounces-540242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B89A4AF8F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010AD18965A9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57251EFF87;
	Sun,  2 Mar 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="qWGetIQV"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7401D5CC2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897867; cv=none; b=Gc+1prW90rB04+vzarA4iqXb9hzMRhjmtHnIbWlqG9AgHIYkg7AT7g0zqdcaVj13wP0Nhk5VUQliK22C2pPlvDmssqaLo0J7OgiB0JObWaEOPXMe5B8OjlAjJyALPG0609hn2LAE/JC++7yUafYObH7H9e8uey6ZxnKQXFOWVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897867; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=WWQnBUxFpvYyopgbnkaLxzGc8l770OUqyYDb15p685ApJFHoW1n3qMHh3eZ+ftR2FQmMDWYHkzjAsNi4A7RFMFNoP3OoevMgj/OuxXbbpAK5kCjiWVm0Mhq0eFJkuWvkaIoBtoMb6vLb8I0AES0dF7yRwe8pUB1b+Hehl4hFaek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=qWGetIQV; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=qWGetIQ
	VLsqrv9Q+0+gfnySKuLLhIyqw9yd4HtLu8O+KwilGF6lIvfICfuw4puXY51V8nW3
	VxAZtjDWjjFwc8xaAye8v5TuLJXJmX1KVD9JP4tMJ9naA8pIKQY5i9qK7nec2sXW
	5WyKLj2ETUSeqZNH2ALho6zVHvo2bfbTZS6Y=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnz9BF_sNn8527Bg--.59152S2;
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
X-CM-TRANSID:_____wDnz9BF_sNn8527Bg--.59152S2
Message-Id:<67C3FE45.07045D.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:22 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifhgEumfD7erZrQAAsP

Hello! Rust is better than C


