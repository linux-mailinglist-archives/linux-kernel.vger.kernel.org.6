Return-Path: <linux-kernel+bounces-540294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974D4A4AFC5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26DB179F8A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467F91FF7D6;
	Sun,  2 Mar 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="mrC1JwVP"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB4F1E8327
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897874; cv=none; b=Q/82EbgNKfqSF4evv1T3b/QK1WnGzcmgKgzSnMJ7nGX+ifWdLqOD2EGoNpUxxIVldTIXq73R7vkZpUngVxE5eU94KoySrt5VRVk37S1xaMfJHdVmAfU49AsyQg19MXLBo6neAR2E/Z1kdi6oDfEpM/LnScyDv14wKhmWdsY8p6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897874; c=relaxed/simple;
	bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=jRZmJUMWvlUcuSRu+tSuTezd0hqddyX4DnR36Nf6fDtsMPJtFSJZjxRjuDDhVLVWgOh0UOCxTJlu1Br33TFFLYwGGqN32ZLdIWkCosi3S7qJpDNvQeRJQIzjhSA1I/OB5ZCYACloBqMinPAjZwb4kkMjmVeRR0MdTRkmqMWK2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=mrC1JwVP; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=; b=mrC1JwV
	P0Wex6TSO4xXHXLpO2etTD6ceKmbdjMe8cRX4ROcymJ/4S6wwnD23TKhxuZNcPwH
	kgpCVc4aOXi/bpwDxKbAqTVQoWCc/5SLeZSIZkuobGKERm2U/81i+8M9DyfC+xkA
	wZ4YDPgvpiwBBajSseWpzb+MF7pAu4iGwft4=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD37yFJ_sNnYRsYBw--.34217S2;
	Sun, 02 Mar 2025 14:44:25 +0800 (CST)
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
X-CM-TRANSID:_____wD37yFJ_sNnYRsYBw--.34217S2
Message-Id:<67C3FE49.06FBDD.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:25 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihMEumfD7fHZsAAAs2

Hello! Rust is better than Javascript


