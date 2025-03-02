Return-Path: <linux-kernel+bounces-540394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1004A4B035
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5675D3ABEFF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F2D2475C8;
	Sun,  2 Mar 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jsHKyt5p"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAF81EDA20
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898746; cv=none; b=EUefOpBsXZ+N/WIZdysrabfW/Rek6TnRoUVIgFdHt419STcsaSF2SmNbm3VYBq+l99Rpo9Xy+R5N1v0oLDSv4ADGFhNzfHgypNyiku0Un5b99ye9JOftWs+81LhVuHAG7KD8HMOSfaimf0D9v22SPHpLrnSYxMZFev3LV0e9YhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898746; c=relaxed/simple;
	bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=CtVlSfSIC9+0kTPPq+NkTHknfCtWaoIfHXnKAkO8F/fHeebHmZEEeMphBq0+FiocbSiL/efsD0WjZbB+RU0+30usKtCPIzWd71AsbON1KM+x5CC8+Pf599NBILpi+VMtjL1y3K0Noe5Q8kjddfprn7A6mSLsvK1JCSOuXGyWwJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=jsHKyt5p; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=; b=jsHKyt5
	pdJiqMt5q+HtAhm0AS6qoRaM6Xwyd5LmBvYAod+CjoeuXFjBXpcWB9Pos+4dtSBF
	+IaxxKxifDDz4ejBOY+U38f5iWGlctIjMwuvP5z0bO2jNoNjrHO0uTUQQkOMxLTo
	jLD0/cQUgNFW8Vca43brPM/L+KyvUHxXPcE0=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3_3wg_sNnjmgBBg--.22192S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Python
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PikvCgD3_3wg_sNnjmgBBg--.22192S2
Message-Id:<67C3FE20.0D9DB8.10732@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU6fOzDUUUU
Date: Sun, 2 Mar 2025 14:58:56 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigoEumfD7fHXewAAsq

Hello! Rust is better than Python


