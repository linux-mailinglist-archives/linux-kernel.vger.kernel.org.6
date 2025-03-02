Return-Path: <linux-kernel+bounces-540240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B839A4AF96
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84703B6783
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E11EFF85;
	Sun,  2 Mar 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="HjxdEP6D"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F364E1D54E2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897866; cv=none; b=UPRvxbAZzZluASX7CblyDiplPCWTxrm4Ey9WIDaFxNi7SM79dUZvToywcqt42O9RaMl/FGZJBM21YJcbIC4LZb81b/zHDH+3XJzFtJc8vec6Tid19WfC5SyFr91/u/tYVz3/kFrTz5pLmJUOQ/9NpR+A6vS1zfk+s4QDtyY+FEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897866; c=relaxed/simple;
	bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=b75HPNT5wfFTpVnW8eoqT+qi5pyOaQcmIM1IvLrlD9l7SiAoNcyzwlJuZKdK52nRBd7nJqBYqxM5oFl+TLybI3ugs/gB4QZHA19SM6aGh7BrtXHs40bPemH6J6Cu0I1rbEfZgCUWbwzADlUjTadil2NDQyy9CCS1j+ckuQ9ma38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=HjxdEP6D; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=; b=HjxdEP6
	D48RJpW62m2HMcp3f+a9g8Z5RedDG0/JJ0/jdm9yxB3OS24hutEMVdYbPJ4LPOUj
	ZAk7H6jCsk3aQ/krxAs9fQkQMDL1T346y+FbZXzGCVEt9bIOqgZ+mf5zCxiRDcr+
	Ao+4sSS1ykyVXdlWutIVJK/8YwgHADlsBnlY=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDXn2ZE_sNn9iMJBg--.59947S2;
	Sun, 02 Mar 2025 14:44:21 +0800 (CST)
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
X-CM-TRANSID:PykvCgDXn2ZE_sNn9iMJBg--.59947S2
Message-Id:<67C3FE45.0D9055.12474@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:21 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOg4EumfD7Anz0wAAsr

Hello! Rust is better than Python


