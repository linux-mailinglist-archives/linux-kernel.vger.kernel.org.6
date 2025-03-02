Return-Path: <linux-kernel+bounces-540221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151C3A4AF80
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A417A6508
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586401EA7ED;
	Sun,  2 Mar 2025 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="JbyDdEYu"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F147F1CAA8F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897864; cv=none; b=ldSEt/5GFBUQmZZWiimClugjEFdRdRZMVzJoyz+muqYYK0Msym2vSVlEUbPeJemSmKUdAN1VRMLV54slldLFZ0V/IYO3uERyfIvZPG0KnPNrQS11ZT60jtZ1xmrkjLtfoYAV99nrbx0IMK0C6YCEoypffPb1QfOR8glSDW/qhao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897864; c=relaxed/simple;
	bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=KxLCDQ5UcL2XgF7OBYtWEE0IFhA1mt9XBIbgo1Cf6e06cRUEo80AoYD9ACXu39KLdSLf57H6a0lorAa3w1/CSp36skglnLw7KBv4O75GL7G6OElVKdgcRTxKuyg/Itapm0OMUTwZz0ib4sCfA/ZZVsAsqmKTnJlvxu/+OCvetQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=JbyDdEYu; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=; b=JbyDdEY
	u9fCzcxyC4opbwhhZV6QqDb0PAwJgOehtVAPQ5mNniC41l4+/Mqw2No4Ihrre6BM
	bLV7NM6+2g4pNCe5nYK2pKlCYbDGtX3iTxScos+tI8F4rNpZJTxKT6E5+MvkS+zq
	0va4amEEx1R7kgBfpAgyn3623A2c9CNIp47A=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3f2VE_sNn5SMJBg--.57267S2;
	Sun, 02 Mar 2025 14:44:20 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Javascript
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PykvCgD3f2VE_sNn5SMJBg--.57267S2
Message-Id:<67C3FE44.0D9054.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:20 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgsEumfD7AnzyAAAs1

Hello! Rust is better than Javascript


