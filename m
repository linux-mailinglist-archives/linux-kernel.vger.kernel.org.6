Return-Path: <linux-kernel+bounces-264030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEBE93DE1A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9B5284425
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE34CB37;
	Sat, 27 Jul 2024 09:19:29 +0000 (UTC)
Received: from out28-111.mail.aliyun.com (out28-111.mail.aliyun.com [115.124.28.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC491FB5;
	Sat, 27 Jul 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071968; cv=none; b=h9pCnW3HJybfYGcZAMfCjDiTTcO1ft83iJCbOPRpaU97EjhFHZaX+E2PAoiDCO+mCbHhqLlDJg0qPqbN9rBSG/b/vBhAehUO4vDzh2Y+J0KeBVJPwGSolat2Gwd36c1VZ6/bATGLVGI3XINDeH/qwGsD7KbyUBBv0LWsl/oUbzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071968; c=relaxed/simple;
	bh=vwV6HZzS57L2bAy/C87Rf/HowgQQU7HNyLAMw0JW6Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r++aNbOjPcS2BAzQEAo4+kZoNSmR/ndWpZzaRNdkTewu1meZ4+OAACf6K8dRXEbZIqkSvFtDHwfLbLo4vSQJrYjAXFhW7qKQqXMzvaU3+ZuaN2yDDbfn2qrwexEOlOH2qG8O92wBqJgzS7WyE8+4ppwPEqlnMdeeqakqrrmT14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=SUSPECT;BC=0.6320097|-1;BR=01201311R121b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_system_inform|0.00644693-0.00010362-0.993449;FP=16924836216495980020|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068194251;MF=frank.sae@motor-comm.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.Yb75cQY_1722071950;
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.Yb75cQY_1722071950)
          by smtp.aliyun-inc.com;
          Sat, 27 Jul 2024 17:19:13 +0800
From: "Frank.Sae" <Frank.Sae@motor-comm.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com,
	hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com,
	suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH 0/2] net: phy: Add driver for Motorcomm yt8821 2.5G ethernet phy
Date: Sat, 27 Jul 2024 02:19:06 -0700
Message-Id: <20240727091906.1108588-1-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 yt8821 2.5G phy supports the capability of configuring chip mode,
 also known as serdes mode.
 add a property "motorcomm,chip-mode" in
 Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml

Frank.Sae (2):
  dt-bindings: net: motorcomm: Add chip mode cfg
  net: phy: Add driver for Motorcomm yt8821 2.5G ethernet phy

 .../bindings/net/motorcomm,yt8xxx.yaml        |  17 +
 drivers/net/phy/motorcomm.c                   | 639 +++++++++++++++++-
 2 files changed, 653 insertions(+), 3 deletions(-)

-- 
2.25.1


