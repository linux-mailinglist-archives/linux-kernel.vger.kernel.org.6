Return-Path: <linux-kernel+bounces-528493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D439A41867
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFF31743A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3F24C692;
	Mon, 24 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv8vYuVQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F324502A;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=PHBFHUK4cXqc6ZzZF+GKcL2qXSHPMKgcaif9iGk9qXKlAigoPzw9qlVDBbA0QrOVLvKE+T5ahwmSeVGONsv9gMDFn2cCEFtSYNnB16372qft7iNCkFKU35EYhjak2UWEFgtUMwk/PaF4myHDbyyrfwg/fiLYKgetLbhomdFw8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=pT2AurFk7T5HHxyb+zGbm0v00i4Pdq52KmG0zBAistg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX5+y1DEfLlKl79lTHNgKkjP7JxLoVznCNk0+GFlDv5uqra1VUF+xLwgfiOnkiKyLyZbbWyyeLL21uNCiYGZOl4kr3RcSeR44nh/Z9kvIohuFxuk47Oy/QtV4iSkG4RjETHyhry68VDDwItWPuh2BcCmC1p7bj8ku9NM+3c2kzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv8vYuVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8E3C4CEEC;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388142;
	bh=pT2AurFk7T5HHxyb+zGbm0v00i4Pdq52KmG0zBAistg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sv8vYuVQyJwlQu80wHvaXf9C/JDwd+l1EnPRZHF4x/8Mpfy6WjfTv7SM4wga/ummr
	 E/UZU2VhHlsPnqxyAGY+SLCR6I1O3z7RpEP+3R4kHlZTn7wO1TCJUa5b8Pvead3YeU
	 eji/WzXo3usb6Ct07Hq50GYPuaNneceSphPCvFEH35mMHlwkfYZ2qUF1AmdIS1fUvG
	 W+V7X30cBtKmLTSUNNPmXzlxS4nIyG1it6Ok4i58vLMIaqwLLSQt9dX0vOzHwg18is
	 +SIDwauYBaVMwhynVeb6sDeBrvEYMQDHeS7xhLQLSwWHkkWNdgyyvYura1CMHiOpeu
	 snlcuccbGh2+A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUSS-00000003p3s-46K2;
	Mon, 24 Feb 2025 10:09:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/39] scripts/kernel-doc: rename it to scripts/kernel-doc.pl
Date: Mon, 24 Feb 2025 10:08:13 +0100
Message-ID: <52d0e3a45dac63af3dfad23103cd4365fb12686c.1740387599.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

In preparation for deprecating scripts/kernel-doc in favor of a
new version written in Perl, rename it to scripts/kernel-doc.pl.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/{kernel-doc => kernel-doc.pl} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename scripts/{kernel-doc => kernel-doc.pl} (100%)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc.pl
similarity index 100%
rename from scripts/kernel-doc
rename to scripts/kernel-doc.pl
-- 
2.48.1


