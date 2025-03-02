Return-Path: <linux-kernel+bounces-540315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EFEA4AFDC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D7A17C4E3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAE7205AAB;
	Sun,  2 Mar 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="IRFkq5DG"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315491E98FB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897876; cv=none; b=ZYuty81+Ycne7+1hdM6Y7gdzCcY+NyO59i5UZG4E8nVLpcFnVZNMfmEV7ggJdBxZULE1e8ghf8rp9kASFaiMWGiQxjakOHjYb5/WYIo3SSvA3hw1+JmAyXppfNnCwkDSumuaIrqKUqnOVyNZlJULa72ssOaCdWZavO7mgCOk1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897876; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=izrDBDYxRJb49R9bL1hZKwDV8NqHWeEDDlb5ee2oIxcP5gB6sTXm22EBzXz/tV9GFZkuDuWMFyGrjc36HsfDWCJljK/g2uacc1bV8l0jqgV31rp8QAG8GV9lKvP6Le5LjDfIawxftCOw1WdzXQ7EzbjxxUQ43zBBhMA7kZKus0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=IRFkq5DG; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=IRFkq5D
	Gki/x4OWefpJ904lB6e+/V1sh17nYJdur04mzbB6zEWlRnbFQHykusYVw8sUJoVF
	MSiRuLNT9rV64ZQp/a7MRCSKEfyXvl8TXmMm69/VnAGgmgR8IeuqreHHH3Xn97P8
	WJVRI+jT6Pkl5bYjtcxwVuZYAr508A/BG90Y=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgDnb3hJ_sNnVm8BBg--.18943S2;
	Sun, 02 Mar 2025 14:44:25 +0800 (CST)
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
X-CM-TRANSID:PikvCgDnb3hJ_sNnVm8BBg--.18943S2
Message-Id:<67C3FE49.0D9DCE.10732@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUg_cfUUUUU
Date: Sun, 2 Mar 2025 14:44:25 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgAEumfD7An0IgAAsT

Hello! Rust is better than PHP


