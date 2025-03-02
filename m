Return-Path: <linux-kernel+bounces-540300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B9A4AFCA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5603162550
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837F51D7984;
	Sun,  2 Mar 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="M8P/16ts"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E691E98E1
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897874; cv=none; b=j4g/s61/ZyagWcrmr1HGuXL9/d34e/Elp/gk8vssgDJSluKFBuXKAnn+muHLn/X1hJZd6TYf4Iv56QqNLePehVW5Xt4j5LuPZ/vqv/Z/L/IyZXdhL+6Mi2Ltspypo+ayZ9ey37lM21s/sTguApWJ5rkky42PZ7wkXiVWf8Ij7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897874; c=relaxed/simple;
	bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=udg7wrZl9P1pHmixsL1BQ74MUinN9uEjdMW8zWcxVX8AmwSm/RJUNeSbxzUEDNaApHN0JwlLHYwra2ZWhXeCKZ9NDtwFw6x+s7JBScARpp7nPHn6HVNQpGLuzyzTa8MGvP+GvY3YzV4R6kafqCFPKst0fYWbtp1Ysup6cdsp4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=M8P/16ts; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=; b=M8P/16t
	sZ/DWdZpRZct928PMif7fisvQ2DS+DgqqN+1F8IGD2nyfeM1RQBtuAJqDfxPaigs
	Dc82ReYAi2AGtnpR0uyb+Pzl22itgLAS2Zr+kC8XwDjg2T88xkDWARFjka3lmN7a
	9XO/RvxJAOSLlVNG721NaDaM0wtsAJhds9Z0=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnr7lI_sNnwNMgBg--.23843S2;
	Sun, 02 Mar 2025 14:44:24 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Swift
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wDnr7lI_sNnwNMgBg--.23843S2
Message-Id:<67C3FE48.066DCD.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:25 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigIEumfD7fHZqAAAs-

Hello! Rust is better than Swift


