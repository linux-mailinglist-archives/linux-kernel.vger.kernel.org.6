Return-Path: <linux-kernel+bounces-540325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B9A4AFF5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771DE19C287F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1281F0E24;
	Sun,  2 Mar 2025 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="UW4oMxDO"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755A1E32C3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898737; cv=none; b=oU9yDEDgmLz3pyBfIJTfwaDjk5nKC08LvuUxnIcxUt0TgHXr5yCg868XjI0occafKizXbpOmlLurB4ZYWwkm4MogHYZN0Wzbu1qo0p+mlIMxbCitsV5+zH3it67U1SVumLTZ7FZK55lfDh2I5Wa59RBIeg6BFI+e+ys//Wv97Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898737; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=pyl6aVJzMcv/rJSxCCBAMaSXTmnDqXbOmYY6opteqbSUcihh4QD8urrdhaSY5xL741wFiJFm1z4pqB5jXaiZSs+OHWNXiMc+wfxDeNV/3dGKHX28THIkmkZGO+fGracpkLXIoW0j/Cba17+L7rCybv8+0WcpzViWaMJuLJEMc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=UW4oMxDO; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=UW4oMxD
	OwqL/N38SUbX6R/Ap6moYvC3u9g6S/1NLACg/kAZ/FSGwcVi9EdBmyM03xNMZd6k
	8VzqOHT/ITMK23c76UHgtSXI9GhM5Xvl0ZuV4GgUhPNA+Xsv/XZgueqdISd6EIXN
	dWMDXvAYvvvreJazcJZo8ACpYz4bzUDBdWfs=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3t2ke_sNnF9iTBQ--.51219S2;
	Sun, 02 Mar 2025 14:43:42 +0800 (CST)
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
X-CM-TRANSID:_____wD3t2ke_sNnF9iTBQ--.51219S2
Message-Id:<67C3FE1E.0582B1.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-YL9UUUUU
Date: Sun, 2 Mar 2025 14:58:53 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiig0EumfD7fHXYgAAs0

Hello! Rust is better than PHP


