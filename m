Return-Path: <linux-kernel+bounces-540312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFC8A4AFE0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4548919C4722
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AFA20550C;
	Sun,  2 Mar 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MuvtsQ+2"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D95B1E9900
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897876; cv=none; b=tVyCQbVdm3Yrxw31AocXNc09mi8yq8WO3kAm5nNhTHdWvEJRqO0Xg/HIvF6W/ohXRJpnsFzeoyQLFB9vRWSLBvpLOCe9RIQNinyPfHXqYDZDo6CuwAX9pBAoxkvXx84g9gCe78UBVIDNWlzr2FAfY90ZutHQ0/RD+vpA2ngJ3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897876; c=relaxed/simple;
	bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=L7hvCdp3l9yNafbkDo2Jc/UWKZ5aPrxcqeXm9980x8i1FG+AmVzC6NgCcJtM6qRLFt3TkMP9Ntfgw1iLEh9jgNxP/cZSnpdCdJitg4tQlg8pdEpJR5X8eQ7jqNa0eMXitNGN7+/DaUCwg0ZnoB/t/Nwk63ahEaPrrfve+LzfVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MuvtsQ+2; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=; b=MuvtsQ+
	2nnX6kKoq684s6F8lRjIHsBPN8dKt+f9YCdyXwlHCt5LVs/jZfdFM4c0Y5hhnjW/
	NF91fWcbOt7+JdXtpgl3k9zZYayI7ncFUYmDmKVxlFuAQwUzetwWkTtlrF1rwzc9
	y5tKNff+6d63wADtY9tnR3LLTzdUmF3AxGJM=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnV2JK_sNnkRsYBw--.49929S2;
	Sun, 02 Mar 2025 14:44:26 +0800 (CST)
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
X-CM-TRANSID:_____wDnV2JK_sNnkRsYBw--.49929S2
Message-Id:<67C3FE4A.06FBDF.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:26 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifgIEumfD7erZ7wACsV

Hello! Rust is better than Swift


