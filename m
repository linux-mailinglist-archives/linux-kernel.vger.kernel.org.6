Return-Path: <linux-kernel+bounces-540275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB46A4AFB2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F38D16E80D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1881FBE8C;
	Sun,  2 Mar 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MQ3pcUMP"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D11E22FA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897871; cv=none; b=KZ8qxO+DbRDSZrvxw6G08OX4q572UkxK8wRK0rs0l+FnVSQBtJSOPlrroyqXEGjigIx+Y4DN7Qc+jRpcIfk3U8ad1MkdoJ9q8lKKA2b7QICEhu25E/7DKICQCFOWkPfGDoV2DOl7AG365R1WdEOvxIUHQXuV1p7yDPB9eXP6prM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897871; c=relaxed/simple;
	bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=nGGi0BW2cIGQT/fKm1RPih4YxR2KD2+4TYsQan6w3Ld00j9VP8InCjabOVX8/1cemyyKXC9sLWIerISKU/ytyo19ajxRgUyrGnu/pmVgXjxHBEaD26qHhCr4B7qn8GMnWDaKDb9sESrlrZvOi1vGVh89IRnsobasaqkAwJk1++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MQ3pcUMP; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PchpREbeVuSu33VarUHMnUKVR1nscKOKnSIs1Y8iilo=; b=MQ3pcUM
	PFqhOKgVV2nJsY2Tub4OiSFpDHej9fKDALoPAP6FLgbtgMWm7gA5Ync4hcqHU4pq
	dbnJ+DuX+ljcfQ3hJdPEebBorITKmvKiG5PT8YvCtGQTZ1A99IZ+xFFzWt+v/v3h
	JYFh1O1CljRZGzNnkZlPkmbyw+lJuwSCnSkY=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnX1VH_sNn0+U4Bg--.3397S2;
	Sun, 02 Mar 2025 14:44:24 +0800 (CST)
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
X-CM-TRANSID:_____wDnX1VH_sNn0+U4Bg--.3397S2
Message-Id:<67C3FE48.065277.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:24 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihAEumfD7fHZowAAsm

Hello! Rust is better than Javascript


