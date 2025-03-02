Return-Path: <linux-kernel+bounces-540290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A2BA4AFBA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0148F7A96D0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B5AA94A;
	Sun,  2 Mar 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZJW7yOFq"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938E61E7640
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897872; cv=none; b=eOruDAaI5/PLy1zjQIxPVw6PeqZ4egHqtZoDBiTodQaangKTSsMylcLzzswBoC7pUR1GlupelOfLcUWogxQvBCk3lBH3nRIVLiXqEY6iNjMmnQxUMRi0ABDIKZwk7gjvhkUH4AMxEsuow8DwFCxGgeAtSe1s8C8bhk/ONYtyUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897872; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=USAMnX4/RCmWXc8HefVdS1/ccm3kEpWaZNlYjHI74c8sA9ZhRfNDnUwouAoMjkh/I1/7fkyQtcUw4CTPNUxIb5cm+vlW1OLAocxrl7dgII0acW5HOVV80VPHnxV5AUkyF3uHwkX0c+fGID99zNbdynyN+ogzNQPz7BSIfc9ndxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ZJW7yOFq; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=ZJW7yOF
	qsMx5HmvuN6Hlo05zkYZlXeaNlvGi6yTPVWLqxokge2mSdUE8q6F4Py7+XQHrRG0
	/OSPVGSu73f5IrXTtmVrTIT9bPmakpHhKO6p1T10o/ehxTBOK7Qv7sAg2HfboIWX
	hf+ZV1743Jp1EOhizKYj8IL3VTggNeREJ7IU=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDn__dI_sNnhkhhBQ--.52223S2;
	Sun, 02 Mar 2025 14:44:24 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PSkvCgDn__dI_sNnhkhhBQ--.52223S2
Message-Id:<67C3FE48.0B5A78.19577@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUgjNKUUUUU
Date: Sun, 2 Mar 2025 14:44:24 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiigUEumfD7fHZqQAAs5

Hello! Rust is better than C


