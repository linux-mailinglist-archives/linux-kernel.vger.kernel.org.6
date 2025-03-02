Return-Path: <linux-kernel+bounces-540376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B46A4B00E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E1F7AEDCD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBACE23AE83;
	Sun,  2 Mar 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="f1+Pg4z4"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8A51EDA1F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898745; cv=none; b=a4rsrwBifYC0tSOX6oEKxGxdkdSkLHQ+OqMgcuO5hy34BmAuVwW40Z9YbNfHkvpchh9xRer1PH6rKudvgR3MFQ1OPNRNw63O2/G0R+RcHvS30x+svbfw/F+j3+PAHvGswbm7SDjHxXLGp1nGpAmwSRVid8UtCePsuaYyLLi0t9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898745; c=relaxed/simple;
	bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=PiFEFWdx/R171PAk/rT4JDXTa/Q18TO947ctfePgCoHuiqVw9WCmTwwy1lXT0BkvLz5FgtOmpsrexqx3IPMbVRPtI8K2PdsZXdly7iYnL3mB3TItLutn0qUaXcIGdkJ/lybQOzNJw+32vuRDP4y6zwEQRg/2AbrTOIitYZseZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=f1+Pg4z4; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=; b=f1+Pg4z
	4Vt/MqQyjvRdOw5cTAe+g9Z7+c3Obl3XbJzTin+RI1/9ETuV5YaSLZ8U4CNOPxOc
	mC9CQAokxSuUeFjSQCSRGIdKjMLp8AW0+sDDjjcCa1SE7hKoIRMy+R+1Vs0xI0eC
	HjtgxXcBdh3vIcHxXb1sAtrldJjzwkiEGnik=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3_ywf_sNnfDZkBg--.41216S2;
	Sun, 02 Mar 2025 14:43:43 +0800 (CST)
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
X-CM-TRANSID:_____wD3_ywf_sNnfDZkBg--.41216S2
Message-Id:<67C3FE1F.06E750.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUTo7KDUUUU
Date: Sun, 2 Mar 2025 14:58:52 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigAEumfD7fHXdQAAsu

Hello! Rust is better than Javascript


