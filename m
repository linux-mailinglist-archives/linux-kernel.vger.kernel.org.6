Return-Path: <linux-kernel+bounces-540302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6652BA4AFD8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7C419C3B85
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B291E1E5B9F;
	Sun,  2 Mar 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="W341ETEf"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287621E98EA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897874; cv=none; b=VYvpCdPeu274lPoF6CAHYFBffsX496Ulp0e3ooyqsj+UFb+9ZSjb8YPyjLctavK9yLbcrakMAb/xCvDcQnSfuYhhmeLPbH2xqYX3tnOyxrBdmqb2TbsCpyEahkgyet8uwTIG/ijVvWI4b9igiXKZQPOlLg+1jwG2u5zaEsegzrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897874; c=relaxed/simple;
	bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=lKUQCkwJH25YUEHqiszUFzsOTnrfbrD89X5wLgJMrqQMrYlKqSxkihFG69gjiW4z5Wkw5fIstL2pgea/rYJXvxyumuDSOHrgfJk0ZvBdAYkimUZh4X22WMUJknXoYEP7MiLPLa4cKNNgCMu/77ALEMCMLIg+Z+woOM4Qg/Gpxig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=W341ETEf; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=ImIq5E+yzSMuk5VQu4015FnEeU4ZkIfZhZtOrHrX2Ew=; b=W341ETE
	fyjwVFZNFnTZs0M/LfiboMXIRmToHNK5R4UPdLzuiqioYonSH6IT1YFsifCPKMGf
	87Ffv3yjSlrOL9n39T0cNGTHEApYMPVX7aZZvryWKI9ETMUmOjQCSZoDQc3huxnN
	qYME/krgfhi4FjnJLil4iX+MpS3IrkCcAbtE=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDnb2tI_sNnhyQJBg--.63431S2;
	Sun, 02 Mar 2025 14:44:24 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Typescript
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PykvCgDnb2tI_sNnhyQJBg--.63431S2
Message-Id:<67C3FE48.0D905A.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUg_cfUUUUU
Date: Sun, 2 Mar 2025 14:44:24 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOhYEumfD7An0DwAAso

Hello! Rust is better than Typescript


