Return-Path: <linux-kernel+bounces-540402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74617A4B03A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E90217C368
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F334253348;
	Sun,  2 Mar 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="CXKDYTiy"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C501EF38A
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898747; cv=none; b=Fd15iHkWqXbf3jCxyV2uV58gyM04ql/xVSETsVKfQL/x4oR7P9MrDnY5DfK42mkle+oYBRF29HZNMM/6I3G0DrLyU8WlwazqRFHQGJ+rnZebkXSMcSefW4kQ2pt+ajB3pdXx2Eja8OborO8T7mx2iMvsJuIH2upAhPJ26qQxkqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898747; c=relaxed/simple;
	bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=PXKJjjyrCUXVB4LTfFkto4VJE0180gVjBqz5BjIo8av42VHjcVDYfClj/lF0wrvLdcEeEPaBzRLhDcoQP2FfmSuliLtrGhWDWGt7xWJUSOJwMGj9DxTNGR+cY4urU8oPQ7MsCf8eY9Ho8jFYaa1yC3fS5tMK/ZGE/QkNNw0p3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=CXKDYTiy; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=cftqaDB8AEPz09qm4a8a9qxUPytrv8Vr6D6ryPJtm4g=; b=CXKDYTi
	yKxLZjF/QPDtZ+U/o/tpP0skHdx0jacz9AYVyHNj4bFMxZpze7q0cy31/o1jZlZO
	TgBTePf79Ivua/VnkGWYoeCiEkSmm6z9C/5w31RVOeJl7SPv9IyGIkhHMo5czI44
	/cWHzFhRrs8YkyB+W+X2wf2/NdUW+wrzXDus=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Fxgk_sNnGLxZBg--.47649S2;
	Sun, 02 Mar 2025 14:43:48 +0800 (CST)
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
X-CM-TRANSID:_____wD3Fxgk_sNnGLxZBg--.47649S2
Message-Id:<67C3FE24.06C8CE.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5fHDUUUU
Date: Sun, 2 Mar 2025 14:58:58 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOg0EumfD7AnyEQABsq

Hello! Rust is better than Java


