Return-Path: <linux-kernel+bounces-540227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA1CA4AF84
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AA93B42A9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF231EB195;
	Sun,  2 Mar 2025 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Ekh3VQf9"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C05E1D516C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897865; cv=none; b=s4/1yfon15c5YqGdlOp97mG/q+GQd0b+HrN+Neb1yEtQUSt4ImRBjEHwhY0az+stFn+TWDt/8BXmlPI7N9BF8GxIGwS+xhKomZDvQcnEAF68FD2qGO/axGW2sI79Mj/zZozDbrk0W0+m2BEv67D6dYyeukl4+bSYMtYTibw3cAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897865; c=relaxed/simple;
	bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=YT5WGd1yIhsya2LtfNGLnb3ouxcA0gSySFXs1KhQHUix22hPiR7Y/Fhjx93knPX8C69mbwVPrPVYvVjwbTtpqhuZUTqIpr9P4AauTivU81EgasdI0V5kZvExRhzsd8GsCNdlMvB3ITbIlxVx3fJK2V0TyBJcx8HesaMTmM9b+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Ekh3VQf9; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=; b=Ekh3VQf
	9P4E123kvlSkyfyi7hUjB4N1xLZ1e53Soi0Gy1jj3iCtWNRkat9NVMZY/0TFDAcw
	iR07S6+3PAgMGV2epm3PZbU0npP2qgj52+j9Ox22mLcWrdTDXfZJGfa22QmT25pR
	HzAAhmq3/oFWDt0zEbz+FfvRHQIKblHWKbnE=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgDXrrpE_sNnkW4BBg--.47547S2;
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
X-CM-TRANSID:PikvCgDXrrpE_sNnkW4BBg--.47547S2
Message-Id:<67C3FE44.0D9DC7.10732@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:20 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihcEumfD7fHZcAAAsy

Hello! Rust is better than Javascript


