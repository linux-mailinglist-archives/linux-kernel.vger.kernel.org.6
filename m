Return-Path: <linux-kernel+bounces-572534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A59A6CB35
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E31597A6219
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5522A81F;
	Sat, 22 Mar 2025 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="DXAqvnZz"
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69386353;
	Sat, 22 Mar 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742657961; cv=none; b=qV/m7QvTtf6A0Znd4OOBmU0kEnAQa2+XkijoiVgiW7kD3fXV++asYTxqZumXNM//F3fPzlV16C8JDYRS3bep6/xWWjXb32qGyxIgesy800GrKPP6ZTGtEVK3T1YEAkzf1N5dFv7x7pl5Lrck27bFzW2i9+JNEmkg8YavHOpJLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742657961; c=relaxed/simple;
	bh=WHARC3Nzff1uZ5ZfEW+7Q/6rg2A3pfMsEGrJWaxBQjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VCljjzXN/5f6Au1aDh67CsTiWnxmTamMrxGcCNGFNrfe47n/qkflYGGX6+wFGYHqDquEY/ejabWcNARs87ZV0K02euJ10RACWKd0ihe0U74n5tImqWI0n+o/Udq/8pUmRfzzLOHGGgyeHCIZ20/r7/MZ2YGLoh3L0g/jKIwwypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=DXAqvnZz; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 52MFciaa024937-52MFciac024937
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 22 Mar 2025 17:38:44 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <taahol@utu.fi>)
	id 1tw0vs-007cB3-4m; Sat, 22 Mar 2025 17:38:44 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.39; Sat, 22 Mar
 2025 17:38:43 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 933f0184;
	Sat, 22 Mar 2025 15:38:43 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <v9fs@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
	<asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Documentation/fs/9p: fix broken link
Date: Sat, 22 Mar 2025 17:36:39 +0200
Message-ID: <20250322153639.4917-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-01.utu.fi (130.232.247.41) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhaXUgEAQYdEEUMBwsoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhfSFhIWEhYSFpaSAkbBQkMDR0bKAsHDA0fGg0LA0YHGg9IWEhZXEgLBxoKDRwoBB8GRgYNHEhYSFlfSA0aAQseACgDDRoGDQRGBxoPSFhIWl1IBAEGHRBFDAcLKB4PDRpGAw0aBg0ERgcaD0hYSFpbSAQBBh0QNwcbGygLGh0MDQoRHA1GCwcFSFhIWV5IBB0LAAcoAQcGAwceRgYNHEhYSFpYSB5RDhsoBAEbHBtGBAEGHRBGDA0eSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=40sLRjlGyKYYF65xfJkKQZc0ed9roRBzndmq5fi4YXo=;
 b=DXAqvnZzZfUOak86jA7ua4ORR+/1qjVr0pkFH3QR/4kRkW9CgHLAlysUkNcDiccsSjyn8pNYwYpT
	zsqX85iqZF37AyifvFhcveFwC4f8sdIV0xvgZHa5sQ0v0eUYSPbBby3hig+u7KBJjbFi16Wj3MEX
	ZbyngnimDSpJqXwr0TUk4tMt6zoBpAkz/9j9Uoj+lq+lFqHUJeGd6M5W664gTXPqP2FIpUfXerkp
	ryfrsMO6260TyOKAWWeYcRlxtB09+/TjPSDOn7fVeMtvD76PxOCX1GgSbipCjwMuYrOnLGrGfdNd
	gIyMsc32gkF2CMQCO1V9brahMoyMznie859izQ==

In b529c06f9dc7 (Update the documentation referencing Plan 9 from User
Space., 2020-04-26), another instance of the link was left unfixed.
Fix that as well.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/filesystems/9p.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 2bbf68b56b0d..28871200e87c 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -40,7 +40,7 @@ For remote file server::
 
 	mount -t 9p 10.10.1.2 /mnt/9
 
-For Plan 9 From User Space applications (http://swtch.com/plan9)::
+For Plan 9 From User Space applications (https://9fans.github.io/plan9port/)::
 
 	mount -t 9p `namespace`/acme /mnt/9 -o trans=unix,uname=$USER
 

base-commit: 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
-- 
2.30.2


