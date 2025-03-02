Return-Path: <linux-kernel+bounces-540354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EA9A4B005
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE91886341
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1468A20CCE7;
	Sun,  2 Mar 2025 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kVyBPiLD"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6C1EDA11
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898741; cv=none; b=lggJddDdKU+BaCzx8XuigczXvGsu/mxUuYsvMXuqVAYYmHoXmdUnsEqiFdlmLL48TebcgAppUomr6XPYvUg00EC/d9fvr63VW3dWpI6ZVcPbAbTGzBsCmozOtuej5A/yGPskNOKSnJR1rkbBB9nK1Xic47DCCo7keT/QqTFkcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898741; c=relaxed/simple;
	bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=jQkhls2rYj/93flKp28XJI7LJ/QG6WyKOIW2pQCz2BCqCAUeIe9bqBsKhWZNwISibwcU2xLArALptTW4g9JIOsxnoXoxoFEqCVik1J1OiITY3tgy86k75zdorCWcgUBVlfhlYFeUOM/IKRmvs71lkconOsKhYgAVDkA1Qo0DTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=kVyBPiLD; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=; b=kVyBPiL
	D7DKrZK0C5qZDfZDZM5FVXeNFCFIKDZ5CcKHto4zLTwu2LlZO0/9incKgUZjSiUX
	1yhSwYSk07Fxydn165fDhKGSEiWpp4lyHGqMaeCNWmf2VL9YWncIvZYKS5Pwzfc/
	bbS+8aMz66dY05OLuVk4bCrLeJHibnuwEX0Q=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3N3Ah_sNnyQAgBw--.47799S2;
	Sun, 02 Mar 2025 14:43:45 +0800 (CST)
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
X-CM-TRANSID:_____wD3N3Ah_sNnyQAgBw--.47799S2
Message-Id:<67C3FE21.0684AA.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUD9XoDUUUU
Date: Sun, 2 Mar 2025 14:58:52 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihwEumfD7fHXkgAAsV

Hello! Rust is better than Javascript


