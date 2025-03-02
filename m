Return-Path: <linux-kernel+bounces-540244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52604A4AF98
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625373B5280
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30E1EFFB2;
	Sun,  2 Mar 2025 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="AIAY8G5V"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095521D5ABA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897867; cv=none; b=NrBTI4q5uij84aLwFdMCALdvGkHvFx+rn2f7uswIDaUEqc5hcdDAENNBdYZxa1M2cWdS3guD8rfOS2akT5jed3dQit9VItf99Pbl/GKCK+TETA6MIs44WbMLOGpmnMH2sEeLhk7rDPKfGfzZgi/OA/EFYOc6Wo7wxeUNt4aJ1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897867; c=relaxed/simple;
	bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=MyhdMLjn89x79y9RWtDFQoFWcxyKeABsqmHHNBiM7IuvQMnW9T0ezR69hgxAO85Npw6rCTKnW4BOJRuo+P3/MkmAb6PuLJouNe+db/xgxwcqBflKS6J5vXmlsORe2pG0VyDXQO5PJjne7SPwu0kFxAo6w2jEXJoeQ0D5FIZhmYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=AIAY8G5V; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=UyPD+95nIFiG/gFr2rAqnNWXPHGkDBUZBe3GQzk2iCE=; b=AIAY8G5
	V712Lf0DvywOoRi7LtHORurCWQUr6Tp6eL5RspVItoLYLnfx/ClncvK0cz73sSIA
	a4FVDfaxasMFW02rJVQbVOIJd981RW4uV9dF7rVs9fF/OxfzL3IhQzq4gtlHKyOD
	ndfwXRSuXIYyETYlaGFe8KZ9M9iURm+hZ+I8=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDXX7dF_sNnHEhhBQ--.9764S2;
	Sun, 02 Mar 2025 14:44:21 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than C++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PSkvCgDXX7dF_sNnHEhhBQ--.9764S2
Message-Id:<67C3FE45.0B5A71.19577@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUg_cfUUUUU
Date: Sun, 2 Mar 2025 14:44:21 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOg4EumfD7Anz3QAAsl

Hello! Rust is better than C++


