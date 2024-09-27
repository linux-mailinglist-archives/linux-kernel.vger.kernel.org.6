Return-Path: <linux-kernel+bounces-342114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86083988AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF921C2133D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5171C231B;
	Fri, 27 Sep 2024 19:25:18 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF3139D1B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465118; cv=none; b=t5uGA2kTPFj+YFicfTMNk2qW8ae8RMCU5kNX21i5TK671ehvZWB4xFObrUm3Hbmu2bJJ9pKP5KHf4XDCIOPZsUffDYUSKlfu9UtZVxktamaiI0pDCs2efiVHKDMwpEeNIwB1+eI4eauQ2/KYc8OVrVwfl7FKkLyzo7C/lNhzJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465118; c=relaxed/simple;
	bh=fE5B9jr0CDVIPuk+HjWiujyb3H8CaL+0nrrPfJwYpdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIAYUl89on7cx+ZtOnI6cSrXWgmMcEkW8+2nAAw2aSsO7Q4B9qXNQghmKtgDWX3QHHDXtsSA2ElzHq8pEqvDrSyZNbGieD6fkZlze0AL54t/XfWJyF+n09finl/giY+zt2BPhBK1QTR+injKSfoBQN7+5Xnso0AJg8yieTjAsPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7193010d386so2116604b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727465116; x=1728069916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1SnHrhIsosFWX2CwskoAEws5KnGYUd2comwreDC8sA=;
        b=kN50JLOT3P4MyE+tnCtSO3iNnlOFivfTGW9ohEHqsjNlziIE+CeAZLpUdMRQUvXy5f
         2OdSn4hsfaqigkzAce6U2RHhQpbo2SyjiSxY9tCVtFQ9xO4PV610ovZkEFx/4Qz7rz7V
         eimlrBKK/6Y8cjreWeOfPPvU+/Y7GcBvqZOyAl9MFXDr2VxdGrhbd2J2V4QlJyQmhRm7
         EdnnmPCMEbYQWBhz2qZFXR/MvlPnPvQhL4qXoiI9CZ0TfpzgaiGLq8qz2xWXkzh3Fvj9
         ATd3zVQs50kwW9Wx1ip1OYcD/0qulGUlX94RichNx7tSZi2HMHbk+v3r+mA+4NyVdu2m
         zSxw==
X-Gm-Message-State: AOJu0YxkxXx61verzOgDAdx58wttAHpYRMaXXFbmvaY0FJrlbOIMJ5ne
	IZ56sICWyXN+wQj1N00RyGhklM3dK7ffIEVDLQhIB4o+W2VImQkE2QZtzA==
X-Google-Smtp-Source: AGHT+IH5rn5Jp9PSkRSwP2QKUADI8patZQ5nZ2oevNFXvp9meoDpHNO5XwWXfDq7aOOuqaNPahXsKg==
X-Received: by 2002:a05:6a00:80e:b0:717:8f0d:ec37 with SMTP id d2e1a72fcca58-71b2607908dmr6818018b3a.25.1727465115657;
        Fri, 27 Sep 2024 12:25:15 -0700 (PDT)
Received: from localhost ([2600:1700:5b70:4260::43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b3e22sm2015679a12.30.2024.09.27.12.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 12:25:15 -0700 (PDT)
From: Fangrui Song <i@maskray.me>
To: linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Cc: Fangrui Song <i@maskray.me>
Subject: [PATCH] .mailmap: Update Fangrui's email
Date: Fri, 27 Sep 2024 12:29:12 -0700
Message-ID: <20240927192912.31532-1-i@maskray.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm leaving Google.

Signed-off-by: Fangrui Song <i@maskray.me>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 0374777cc662..3faaa5f400c6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -203,6 +203,7 @@ Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> <ezequiel@collabora.com>
 Faith Ekstrand <faith.ekstrand@collabora.com> <jason@jlekstrand.net>
 Faith Ekstrand <faith.ekstrand@collabora.com> <jason.ekstrand@intel.com>
 Faith Ekstrand <faith.ekstrand@collabora.com> <jason.ekstrand@collabora.com>
+Fangrui Song <i@maskray.me> <maskray@google.com>
 Felipe W Damasio <felipewd@terra.com.br>
 Felix Kuhling <fxkuehl@gmx.de>
 Felix Moeller <felix@derklecks.de>
-- 
2.46.2


