Return-Path: <linux-kernel+bounces-540320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A09A4AFE2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580D87AB59B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F91EBFED;
	Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MAELHccD"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C511E32C5
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898735; cv=none; b=JaCED8m6uR/0raKiAeTMngD5FgzmIwF8C8hUgWZicjAhJjlchbDChLnuEBNjiRkG9WXwkp/q/gV4ZtDI4iQyIvxDdZ8Ml7Ta6P7/KacG2Y3T75yZB5hvaUmKBIbHY87TA8ZiORafwo/+0TC96a9pcXr4NljB/8HRwu98jwbISNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898735; c=relaxed/simple;
	bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=bXGWVdTRceA5hkA2lw6qSQ6hoNfuINh8Tyt3caobd2faxPvre+tJeioUDmPulEI9jyKka+n1c0QHOhl4Zdjz3ouhtf5a4qC8Ho7vJu1PCmeA6QrXwrXb9Z+6CVlP2righYtiwhl7Ffhxa3E6E16yNlXo1pd05Oc4KX4oE3xVDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MAELHccD; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=; b=MAELHcc
	DFdAt2wF2/TvD1Qc9TF9C1uTxO7Lf3houTkRqIyF+IOxuBUbGEo5ZMl28/XQQMyM
	dDSJ5AXV0bLnj3sdJyhKtJlmhFw5St45a5EFEZZxfl6TYJpMlm19vsiE9P2+a1EX
	SAyjX0/K7KfyzxyIzKeAQRJgqw8xKwGVNLCs=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3t2Yf_sNnAh4JBg--.56883S2;
	Sun, 02 Mar 2025 14:43:43 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Java
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PykvCgD3t2Yf_sNnAh4JBg--.56883S2
Message-Id:<67C3FE1F.0D9044.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUTo7KDUUUU
Date: Sun, 2 Mar 2025 14:58:51 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigMEumfD7fHXcwAAsr

Hello! Rust is better than Java


