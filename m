Return-Path: <linux-kernel+bounces-566820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077E1A67CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63707A97DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E645B1DF247;
	Tue, 18 Mar 2025 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shurjo.me header.i=@shurjo.me header.b="VF37rF6U"
Received: from p00-icloudmta-asmtp-us-west-1a-10-percent-1.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-west-1a.k8s.cloud.apple.com (p-west1-cluster5-host9-snip4-2.eps.apple.com [57.103.66.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8B1DED54
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325695; cv=none; b=WDgPFJygCe87yA6FOo6tBZ/a5/c6geM4zqGSGi5OuZPbDap4yH5STZp/rtsw8pxRaUWh+KIGmsHYc1gblUn35Jw8t02HMsP3kN9OR54kXv5GWeCU2CCtKugX3taZZPR7VnWM5bOlRJiTPKk1nVAyIwblTpn2cApaet5NN1dYLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325695; c=relaxed/simple;
	bh=ezMlMEag99mvW1GnmMeV6467CpwxaTz6C3EnN/L+RQQ=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=mKCARsCye2AApUsJBrSi6p+U0/sSZFjNHF4No7ljXYDTEXMZqHd/nXcRojnpOJSncTVQJg+Lak7uToNhT5yaNOKgOmQoHbL0idVEi1htfeXumlF2TNsDTyAyEnkeduu43ZPot27Z8P0pn1TQVKRUZFMgbjuuHHzFBApcq9fHWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shurjo.me; spf=pass smtp.mailfrom=shurjo.me; dkim=pass (2048-bit key) header.d=shurjo.me header.i=@shurjo.me header.b=VF37rF6U; arc=none smtp.client-ip=57.103.66.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shurjo.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shurjo.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shurjo.me; s=sig1;
	bh=ezMlMEag99mvW1GnmMeV6467CpwxaTz6C3EnN/L+RQQ=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=VF37rF6UGDUKg8hs5qH7sKlZmDsUiqMDHh/SAUynAMF2tMSwiem1hmfG5gZSz2veq
	 VmaP1PlVyKJPKc4BgpGBtMH3HzQ7b0AQH13vF9CyA2VLsCB77W5eK7XHnFXlxS2LrM
	 +kwdhpY3jRstGk9pHdqLyLlNusOHd0YOcEhsMyySZEGRWbajo1qFWYZZ8fIaDg3R4K
	 JH09emRU8Zr+yHyo8H/UqIPDs87T4FxerOn8I6syZZlXCggo20eSGjLHcyngxxqHVV
	 XkkGXCAtMs+LJwjrjF+SIprdumJ/ed2svvJ+MalT/UCoyUUPz17fuOKdVSyCAh+Mdl
	 L49t0U+5uHEeA==
Received: from smtpclient.apple (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-10-percent-1.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-west-1a.k8s.cloud.apple.com (Postfix) with ESMTPSA id 57B8A18000A3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:21:31 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Shurjo Masood <mail@shurjo.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 19 Mar 2025 01:21:17 +0600
Subject: unsub
Message-Id: <31D92ADB-E517-4B79-8FE0-06DF7C0D3272@shurjo.me>
To: linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (22D82)
X-Proofpoint-ORIG-GUID: y-FCk1Hhko17c0BsBO6WmPCoHFlYJazl
X-Proofpoint-GUID: y-FCk1Hhko17c0BsBO6WmPCoHFlYJazl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1030 mlxlogscore=258 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2503180139


Best,
Shurjo Sakib Masood

