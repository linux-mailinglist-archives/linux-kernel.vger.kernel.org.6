Return-Path: <linux-kernel+bounces-540305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE12A4AFD3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB57880192
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CC11FFC6C;
	Sun,  2 Mar 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Q9l9JIQh"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B401E98EB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897875; cv=none; b=mH8l9gfs1QSkM2BMO+eEymb7VyxOGmpbwMmKmDBzNvbyXUZ/E2lvdYSchMnakQLuY50t6aLJe5Ttq89EY1GaEsZy9Ww+QVeISgKehpsEL4mJ87AxZK7QGG1Oyi0WxhxsV1kfQ3XzLWf1MGHVtkUzO5HexwQ3gJAlFCXbZgTNTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897875; c=relaxed/simple;
	bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=qDXCB/FcWV6dkvacuHwrARoXdW67zEGCtvph59DkpoarbdIxPleVD/tbix1ZxTe2tIkRAlNvl0G6GOFCk6tMWc13gbxqXbWXcg9kztN68R6bCGFPF68i8u0lrZKFuBFSibvhowGDcqjakxK/BEy7vUyWMWn9hQfwvu15k3Mn3Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Q9l9JIQh; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=; b=Q9l9JIQ
	hqs6n7V7dJFG/ZcHEl1SR1ngk7wa5zJb3RvJ232kWhGn4D6dfS2w1IpoxVN7QGGx
	G8AoczKLuTdkySUQmQvWlWjWtx8TrksHHCeMfcXjlqIH5a4CZ6gf1C3JSZoPfD6K
	hLxEB0X4akoo4VLH927vqulRffhRyoc8a+oE=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDHP2lI_sNnhiQJBg--.59258S2;
	Sun, 02 Mar 2025 14:44:24 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Java
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PykvCgDHP2lI_sNnhiQJBg--.59258S2
Message-Id:<67C3FE48.0D9059.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:24 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOh4EumfD7An0EAAAs-

Hello! Rust is better than Java


