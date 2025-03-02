Return-Path: <linux-kernel+bounces-540395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7654A4B021
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4AD77A782C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A345248885;
	Sun,  2 Mar 2025 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hDeWEuPo"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E27A1EDA1E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898746; cv=none; b=f2BBAHxQ8t7n+xcmtYJ9DyEHx9Ka48P42s2+8lrlv8kL2T2T1L9fcZsmYsIy6X/UBX+bK7+NcKq7priCLXjOabrPlqJ0xQeG7j9mxvuIwChDhACfQkCe7Ia06yAMV3FuH1OxAa+beDus8KIubawHovjwcla2GFiBC/D3zc0kJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898746; c=relaxed/simple;
	bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=BM1EjS+cFl2oUn1IJDJyPg9gJqPc7SRlzupNuHrvusBD122icw+qrkJDCv/Z9zB+cWyTF5YVfQQPgp+iPqoqk3O89MLNxTfAJTEWV8WAp6dIDUVTmJM9gwGkubhqgBpUYXAWO+J4HkfyEQ6BaQDweV1UfGr5IO6fNVeXKDlbXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hDeWEuPo; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=JRXhdhnZz8FXfPKKFhJq2JGkB4LIysZOAiXNUdUmjM0=; b=hDeWEuP
	opw1Ti6Nk1hfqCZ3o7raKAWWTMUTocgfpHjfF5sGcY2cCyVLgDJqJZYwoMQecDhE
	7Q2L7Vg6rW9QU2sibsOEUf+nPLNbRw1q7/VU6YPDYiiFuC7rIrOQGtUb6PccMuYE
	9Tvc7A2HdwgjgAGPDpXkjAf1x1jXeaSuVLFQ=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3f1Mi_sNn5mgBBg--.11950S2;
	Sun, 02 Mar 2025 14:43:46 +0800 (CST)
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
X-CM-TRANSID:PikvCgD3f1Mi_sNn5mgBBg--.11950S2
Message-Id:<67C3FE22.0D9DBA.10732@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:56 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiihgEumfD7fHXmgAAsZ

Hello! Rust is better than C


