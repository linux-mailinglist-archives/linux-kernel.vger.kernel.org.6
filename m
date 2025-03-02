Return-Path: <linux-kernel+bounces-540248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A951DA4AF91
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9F11896FDE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2674E1EFFA6;
	Sun,  2 Mar 2025 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="F8MA9IXq"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8CA1D5CD4
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897867; cv=none; b=h71geY0KWHcMHJQaW/gHvx+5MFiBJIiuuIu2ExXeUKH+GVoBzvblHXkrjBQXD6T5uHpLthYXg7LoWnqXp0Jatrdur/byyJp0enP7H1vuEkt633xJUiUSgPB5T7mqUYhkP7HQliynO7mNOORszlkazBbzIVuAb79umsuAm+9v4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897867; c=relaxed/simple;
	bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=BKmO8Il8ovh3eLYClLt0MQJ+ahTRD6ykKOd5+fcmwCfWvUeYrfVjitDsIY4RLNlkvNJW/YQekZfCVMM03APqRM6DFvqldiADXq8mVw/n2jn2KT4MgpA/fOB3R5IuXQ33ppTe6HRPEO5cEEfXKe+8AL07lC0ahjEoQfYbzo7iUJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=F8MA9IXq; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=PfixNPQ/uTp/hFvZCGY1TVY84A7zL5WAfQIAbeeaQe8=; b=F8MA9IX
	q7TWOAZiJmn/BL4MZuuPFsUdqrINe6yWTkupsQMs1/9zAWuvG8t9p1oKc0qN9qxs
	kkH7qm3QI4p938bojlACv54VrUNjiI//iL1kxU9xnwi8Htto5UOHOGpObbEvtPku
	VSGuUI+8Coo3q0j9c3GLsPCf4wMIIdhGfAug=
Received: from localhost (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgDXPzxF_sNnfnzdBA--.10871S2;
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
X-CM-TRANSID:PCkvCgDXPzxF_sNnfnzdBA--.10871S2
Message-Id:<67C3FE45.0F01BB.16940@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUg_cfUUUUU
Date: Sun, 2 Mar 2025 14:44:21 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihsEumfD7fHZfAAAsy

Hello! Rust is better than Python


