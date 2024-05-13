Return-Path: <linux-kernel+bounces-177068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0ED8C39B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 02:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BB81C20CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 00:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A002A92E;
	Mon, 13 May 2024 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="CQtZhS1K";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Y2HWEu4O"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C535234
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715561172; cv=none; b=GvUde9vn0TsTP6OutwDZKOPG8BqxGoi6vPLUVxO3xulrtqJkBHnwwf5j1cXjpfHXpkiM+esT+cgGNGpn+mApDdkOQXk75ftMFTDkDUjDNZ8z//Eaa63XwZT8YapMfVrPtB9BZqhFhsO9mjQM7UcJR/qIJn7aMAWgNIxldDXasyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715561172; c=relaxed/simple;
	bh=U3HjDiAxMJF9563uzlVT7VbJu7d0dpUtMdwb2XVFRSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ts1DZeoAAY+xmVo3yrG2s70Ct6OLyKDZ927QgDFLlNa6qJ1h1OVSDO4Jz1uaaex0I01OePJkZA8W/LrPpX7zFbWt7AwGsb01Aj/5g68sn8UcaRiagyb5yLYK6rWIzFoIGbJIrnjIJDYS9TezaNoSSVKp1S+Vsy4cBbE2Ajl9BhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=CQtZhS1K; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Y2HWEu4O; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1715560725;
	bh=U3HjDiAxMJF9563uzlVT7VbJu7d0dpUtMdwb2XVFRSE=;
	h=From:To:Cc:Subject:Date:From;
	b=CQtZhS1K8uqJ13zOLgmNtlN+yK6W+eAVshedhed4p6vgDVQ/ALOiA+UIlDMIZxLGK
	 vBIdZ7MMZ/EnJfcVNB6oCqCamy4HbQTsTKJc2VEBJNwfS9cdjGWXMEilTBrRgpG2e+
	 1TY5NABigKfQAFCmZtidQIKDlGl48ySi9cUDDx2A9MJI3M63A03Z5A0YojpELljH4E
	 3jEuXlJZwtXtIDOvafaert5KMbNXB/YlK2wUBvXQuT89lWR1BWMAlLb6oDHASmxwvE
	 sBSh1rhPC8qyClZPWcQdqkXu+YxksjCNF27iKNHvr7lX4ouwjNpz9T/R8KAMcpC/BH
	 IF9Had3dJCA3w==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 72C43372
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:38:45 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=Y2HWEu4O;
	dkim-atps=neutral
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id E8529372
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:38:44 +0900 (JST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-240120258b5so3103509fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 17:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1715560723; x=1716165523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HsIEASF3QaB3IZhi8DmVvGv/jkEBuLOkXdFEV40N6Z4=;
        b=Y2HWEu4Op1+M9r9orJyjn1jJ7QNesdYUsIOaNcfcq69WtlgKqBjU3v0BhFEKyobOhm
         yIqwQoQm8oOEDMixbkPLRp6TCk7ZIrBo131BbXJrFmDC3j8hH5XCCuEpB9IHXMunNfm4
         oSFGhab61PtRpp7ZxLsZNCqt//tD7jd8/0XEu+z7L1VtT4NsXodmbdwhwwKIn5i/jC7H
         oRt+v8oDmIofFmG1tet1Da+7Gfqd3ZoaTswlNuh/VzB8ZE9m8xW+KrM3aj9/FvTqbo1B
         l8GpW7Xmaig0GygoaI3Y3Lu6iQydtgUnqxq7Haryw6hskZ25ydBVHxzZ6qmYiRLMQdG6
         cr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715560723; x=1716165523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsIEASF3QaB3IZhi8DmVvGv/jkEBuLOkXdFEV40N6Z4=;
        b=Can3A1ZUqkbb22PXxWVKRGVRUVs8cHLRTSOX+rCB8cxGF4jnOPJulvHzVNMZwek7Wp
         JKEUMrRwj16Eb2OEU7updDy/ZFt+io1WdYXw318C00w2ZUhAUgvo9q7Pt85olqkXvAiW
         O9vWgpUTqKHszdyd2lpN4Go5Npy5Fv71xI6pzN0Hor8ILakf+BRzOU2zlW4AAY2XogH3
         cSGhC+4wzVIbt30g4t2W8N3Y+E49M31QYUrc/1bMgvUshAXOQBmuWUxTYkDWOD+egjw2
         Yrp/e6F9OXwGAc4DGbBJz/enOOIPClfmnEOD9KTNBhz+a1J3AvrCVOzAYfDk6izeg+we
         qFTQ==
X-Gm-Message-State: AOJu0YynPuOlZsvvqiQgcRZ6dVEzlZ3+MAllL+mSnJrI15mNJPQXnExY
	E8zNLbjJiaQmYOH8LLplnA/p+3Mg0ucJKqshR+NoYOVOS1kF9K2Sbqx/DUBtmx80BOjiB70jIcY
	zWOQLnckK01Sb3lNKXOWMD8CmibCX0M97Ga2kL3VxyHfb+2cY7CQyMJbRi3u0lF6Lg8FzXh0=
X-Received: by 2002:a05:6870:d285:b0:229:f988:4305 with SMTP id 586e51a60fabf-241728f4b15mr11061009fac.10.1715560723464;
        Sun, 12 May 2024 17:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuRMyXUQmsEKNt7ZKzSLAVq04d2IqNYnUdmXANU1/K7UrBHCWFXccsCvmTKAaos8llpWIz5w==
X-Received: by 2002:a05:6870:d285:b0:229:f988:4305 with SMTP id 586e51a60fabf-241728f4b15mr11060984fac.10.1715560722466;
        Sun, 12 May 2024 17:38:42 -0700 (PDT)
Received: from pc-0182.atmarktech (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2969sm6179487b3a.152.2024.05.12.17.38.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2024 17:38:42 -0700 (PDT)
Received: from [::1] (helo=pc-0182.atmark.tech)
	by pc-0182.atmarktech with esmtp (Exim 4.96)
	(envelope-from <dominique.martinet@atmark-techno.com>)
	id 1s6JiC-003OuB-17;
	Mon, 13 May 2024 09:38:40 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	sudeep.holla@arm.com,
	Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 5.4 / 5.10] firmware: arm_scmi: Harden accesses to the reset domains
Date: Mon, 13 May 2024 09:38:37 +0900
Message-Id: <20240513003837.810709-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cristian Marussi <cristian.marussi@arm.com>

[ Upstream commit e9076ffbcaed5da6c182b144ef9f6e24554af268 ]

Accessing reset domains descriptors by the index upon the SCMI drivers
requests through the SCMI reset operations interface can potentially
lead to out-of-bound violations if the SCMI driver misbehave.

Add an internal consistency check before any such domains descriptors
accesses.

Link: https://lore.kernel.org/r/20220817172731.1185305-5-cristian.marussi@arm.com
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
This is the backport I promised for CVE-2022-48655[1]
[1] https://lkml.kernel.org/r/Zj4t4q_w6gqzdvhz@codewreck.org

The 'pi' variable declaration context just changed a bit
(handle->reset_priv -> ph->get_priv(ph)) but the patch is
otherwise fine as is.
(I've also checked that num_domains is properly initialized at module
init time and this part of the code hasn't changed until 5.15, so it
should be safe to use this previously unused field)

This same patch applies cleanly to both 5.4.275 and 5.10.216.

Thanks!

 drivers/firmware/arm_scmi/reset.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index a981a22cfe89..b8388a3b9c06 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -149,8 +149,12 @@ static int scmi_domain_reset(const struct scmi_handle *handle, u32 domain,
 	struct scmi_xfer *t;
 	struct scmi_msg_reset_domain_reset *dom;
 	struct scmi_reset_info *pi = handle->reset_priv;
-	struct reset_dom_info *rdom = pi->dom_info + domain;
+	struct reset_dom_info *rdom;
 
+	if (domain >= pi->num_domains)
+		return -EINVAL;
+
+	rdom = pi->dom_info + domain;
 	if (rdom->async_reset)
 		flags |= ASYNCHRONOUS_RESET;
 
-- 
2.39.2



