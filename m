Return-Path: <linux-kernel+bounces-563264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21833A63BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037F5188F07D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E8A155322;
	Mon, 17 Mar 2025 02:32:13 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34349405F7;
	Mon, 17 Mar 2025 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742178733; cv=none; b=d+lxCnx/X9S+vqaLFz4bWKwEyHxke17zJ5/Kiqqfy6qcpmQmAv5t6lijOZCkdFBRNF0LE6R136j8aK9sa3D6f/f7R8s+TneK7yY7K1x4oFTVCtfh4z8ClsauGqhma8ef5TrGUILMYSrIF0astB4q7yRXP0GrEc8PzvDaVr5Ivm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742178733; c=relaxed/simple;
	bh=j+nOZecMB+eGLoFV7lwsCTRQ3mPi5dJ+kqLvxf12vdY=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Hv5aFRWAZdeGt34cpSE5Aknt9amG4Ze9X2I1Sn+/83hSbuNjV9RmrJcfHSCuaaVSTraH9gNfMZ5CKYE+eb8k6WDUshafZjLDCKKwHhA2DRDuLadvB3wBPwcrZPb+pwfdEe/PVh2nrU/pz+TXE48w4YHfNbIueZlqkzPJX4DLAFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGJs400t5z5B1J4;
	Mon, 17 Mar 2025 10:32:08 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 52H2VjNl035173;
	Mon, 17 Mar 2025 10:31:46 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid31;
	Mon, 17 Mar 2025 10:31:47 +0800 (CST)
Date: Mon, 17 Mar 2025 10:31:47 +0800 (CST)
X-Zmail-TransId: 2afb67d78993ffffffffff7-36625
X-Mailer: Zmail v1.0
Message-ID: <20250317103147313V7IEKc3g37STl_idkF_ZB@zte.com.cn>
In-Reply-To: <f11afa64-1629-4005-8cb4-723d9b6ce6cb@hust.edu.cn>
References: 20250317100811126QvOaWRPxSgm2ttU5faitl@zte.com.cn,f11afa64-1629-4005-8cb4-723d9b6ce6cb@hust.edu.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <dzm91@hust.edu.cn>
Cc: <alexs@kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gZG9jcy96aF9DTjogZml4IHNwZWxsaW5nIG1pc3Rha2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52H2VjNl035173
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D789A7.004/4ZGJs400t5z5B1J4

> One suggestion: the original English(Documentation/mm/balance.rst) 
> version also has this typo. Submit a v2 patch to fix both?

Documentation/mm/balance.rst was already modified by Suchit 4 days ago. Therefore, it might not contain the typo anymore.
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/mm/balance.rst?id=f5d10c46872ca9a6d716854354c11f2f32fce0e8

