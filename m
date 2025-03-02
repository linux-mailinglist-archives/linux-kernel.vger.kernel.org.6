Return-Path: <linux-kernel+bounces-540295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62815A4AFD5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752D019C35FA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CC41FFC51;
	Sun,  2 Mar 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Aa2fpIdU"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46221E8837
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897874; cv=none; b=SAcYe7EL9ZAPId6vNEKOasU9/O/u5Fjx1/MHE4QXEq4R8yS1btA+MFNZK6JH5aLoiiYWdGEINIUfG3vN/b0daxfMhOTPLD94+s9B6EwCsm9/tONgJhIXUYwwb/xF13Dd0w2yA3AUEQ3nCFFk9Y1SboXBCwdnRahcjuYeoQy4ugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897874; c=relaxed/simple;
	bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=Dfqu1xfXQKs/Vz4WTHmnfNmG8t9ijY28/cv4Y0ogE9KwH01IdD1nW5uHO099ujzN6S34gHBgRkGTDIuQo6qkjxV4PWDNDV69UJ4jBQ4SK6AiEznnqT3kiyUkOe6UTXCoWv0H2HQbe5KtBBLqvJhNuPUA4vr9zOe88B+mRt3xtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Aa2fpIdU; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=; b=Aa2fpId
	UdSAMyYwvOUT53GoHCyJIEyDKScKSEK/llB97XWIYM9se8WWNzOGBzOzhUIC9AvD
	PFCzH7rXSM/vWr9dhdLJrIqyKbDZZK6MuLaaIcRwn6AnEygChrJ3nzAxsRuUAjDo
	Dqx+OOh6EZWO3CxoJ5TEfNMRfGO/Z5QGQBuA=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3N3BI_sNnPwggBw--.47842S2;
	Sun, 02 Mar 2025 14:44:25 +0800 (CST)
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
X-CM-TRANSID:_____wD3N3BI_sNnPwggBw--.47842S2
Message-Id:<67C3FE49.0684B3.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:25 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgAEumfD7An0EQABsh

Hello! Rust is better than Swift


