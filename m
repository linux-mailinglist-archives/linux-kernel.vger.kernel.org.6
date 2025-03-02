Return-Path: <linux-kernel+bounces-540357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5014AA4B011
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEFD4218A7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B724D2376EB;
	Sun,  2 Mar 2025 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="J8embeFs"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63BA1EC009
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898742; cv=none; b=vEEKN5r4HkVOIhxi2T2YURkldMFpbKjjonrVgBFdkM/oWNArvrrsTA4HQOKXuHQIwZcG8C7V7FMIuD2dbsOYwN8UFG5w0USiMzYTEfqhg8q6A/w6vYFzIzgg7teJbWAnKqdV57Jxq1jbvg51yFjudHrWZDqWjTkb9A1MuB8qPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898742; c=relaxed/simple;
	bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=HFmpsp+JdhlBIt70qU7hbMaRfCX8ds30PtlNNFQKaaoievIkmJy9Tsjbw1jTMj1XuJiJXc7NA5tuN0ow0Ifde9utnXgVnZ4oMiOv9uOVm/vzGuDwSWthLza0LgZqTQXaEOYwveyPM447FBEMNb8L/Z9BLyNMubQxp5ynqjAscFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=J8embeFs; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=U/wIYARQ7kbvgXqE7DzmguflZ6ifai48GUe3iGqWynM=; b=J8embeF
	sCkdZ9mNwmKG1FP/OUeJwvmb6waO7lXKoW2Vy8GnvIVNKbkeh1ZatcQLwTpdCFDy
	Wl+YlBqOPWfGZb6BKDvG8dUWI3HGuJ5HTkXoEhIgk4KKK9ANUFffMwZCdf1yNBbB
	j0zp4fJ9d1aW9jPgFujkL5mlCdVCpgAbxBLU=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD37xAf_sNnfrtZBg--.42600S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
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
X-CM-TRANSID:_____wD37xAf_sNnfrtZBg--.42600S2
Message-Id:<67C3FE20.06C8CA.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUToUqUUUUU
Date: Sun, 2 Mar 2025 14:58:52 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiig0EumfD7fHXeQAAsv

Hello! Rust is better than Swift


