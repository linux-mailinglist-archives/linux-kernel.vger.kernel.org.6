Return-Path: <linux-kernel+bounces-536002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E72B9A47A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63ED7A3FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2822A1EC;
	Thu, 27 Feb 2025 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="KrKtpelL"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C92229B3D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652436; cv=none; b=h1IfVLwtW4MCePqmDMR7lDUVxcNUfb+tLwInj41b7rLVn9IewY56viBCRCjOPxkWF8Pn//vSBujlR6xAj/AbjV0ewnDCL91XAbljKLAUEvv5IFG4p+fxrryBslZpx0zVReSiqH+2UyKvI+eNuS8ehIIqI254SM7Y306mY91eSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652436; c=relaxed/simple;
	bh=yNg0EW/sSTagffgojXuqqjjQihItDBy+BD9n5x9G7iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKqBPrBp6w3SO+qPbkcXalTGVw/7CytH+ZMy7rufB28tcaOpg9ngqLnKGjvn8ge4qReQJGebLyKGw9wdzgNEXBBOVuUGPvC3ZZYds8aBmeVrXyor4gsJv9OPFqQhG3w3Rx2nOkcn1S5Qr4aWF/K2I3vHE2fYiPonte/d481bB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=KrKtpelL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f488f3161so404744f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1740652432; x=1741257232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6I9Y2sm2ZO37jUC9MCmxExXieoBlnX+XT5yv3CFjg4=;
        b=KrKtpelLhQZkTVtkt4uBTi1dJlqgq62w57BMfhUah4dK7iAXWCow6YEK0+uSieNpSJ
         e+lgAM87LbDXBvJv89ujLZ8K8LPPkCU5GaPeLJy039jB4pE7uitCKy0GHZycSQXFQU9m
         739vz1FQO6Mbg75ygwxYE9HmtAdHX7yEfoxAC5aBiyytjVb+N6Edn51TyH025QpAZOif
         mG/KYXOZ1BJB19kubx798uwA5bh/uSgBhXFzYujhzNFH0nI0hf+W8fO9xkKbrTMIAzZm
         NS1SPYiiHdBo7Pby/u2GctH7ow4L1o95AWfOFTATGQyO1t61nx5mgbE9Eo4q7bDShbo/
         8LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652432; x=1741257232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6I9Y2sm2ZO37jUC9MCmxExXieoBlnX+XT5yv3CFjg4=;
        b=mW2AEqZcm8DqwN+hJDBUyQ8AsdEcPqGlr2gZIUp+x4XzDwMJHm50je2JCVSR+u/Azw
         VjfCDXo3Gk39eRXsmvhkUvu5aQNgpR9euCr7q4KEV8WKHqkw4sWxUipwHhw58DuilyKV
         d6RdP6x8dzAZhC5JJhuULYj8C7SB3PxxS6oWWKth8zQOeuVxfil64Jw9liwUk7GMXgoU
         RBJfHYzriZaQHi48PXdwwInWIsAZSuxbmWDiNKCv9JHzmfYXDYrJ2DJGHpvS3ZtxehAu
         0WCnb2BZSiDNwJTD89HUkRmk8geYooYq8dgcBHzKS4sdGWpJSq4qjHvBkC2ZMP7nuKqd
         TA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT7Q+7v1Af9b95SOM9SICbs5PpzBgjlC2sPRS19hZEDVZHTH/cTcYjkx8H6eAGuaoJBF7gEQ3h0hXLwgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5i9RZy+YA1ouwt6L7vJdEeGSOEdBRNbpMJ8cnI52mx5X2GUQb
	GAVUf2HLQZgkG1iZ02f/QrV5pYlcPJAQfcRpdjckiv5G9qv+XJJ/gzKmKrXh9Pk=
X-Gm-Gg: ASbGncvCKfOQFjVAqUdyFJByRMQhW76tJOn2J5SewPmcAXeRU+WVwMtw/ECoVzZd+px
	Ro0K7zPPRl9bVisJJM9KIKdpUYkz1Tpqf8nuMj2G79MWDgwez6qYMpjxGIcdgtGxGxvrA56sQML
	zbwjY0y1HxKJPfSHmgE3VvO4g2PLLQSmB6Q8eftjfnX9sJAKmbb9JcgYuMo/lNsR8RrUGfCwjts
	N5Kh48Mr8vUELObaRYzN9cipum6qQ8PFxUSdUVCO849dutMZFJBYJjvJo3D+rXZQ1cKB0tiyrOx
	hdnxYX2ulAWI6ih+d2ng57aY0J+T4If/ZkF9iPuCMx5W07XMup2W95slci7LiXJopYmFXq4bad0
	=
X-Google-Smtp-Source: AGHT+IFCt9u0coO8uHw2mLPkv/N6QOb1W05JtNtgr7XbEDzVKeQRsZ/jpOW0SzEfoBUonlsoaSDtAw==
X-Received: by 2002:a5d:6c6e:0:b0:38d:cdac:fc02 with SMTP id ffacd0b85a97d-38f70772b89mr17494957f8f.4.1740652432196;
        Thu, 27 Feb 2025 02:33:52 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27ab2asm17854305e9.32.2025.02.27.02.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:33:51 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 27 Feb 2025 11:33:41 +0100
Subject: [PATCH 2/3] net: ipa: Fix QSB data for v4.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-ipa-v4-7-fixes-v1-2-a88dd8249d8a@fairphone.com>
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
In-Reply-To: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

As per downstream reference, max_writes should be 12 and max_reads
should be 13.

Fixes: b310de784bac ("net: ipa: add IPA v4.7 support")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/net/ipa/data/ipa_data-v4.7.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
index 7e315779e66480c2a3f2473a068278ab5e513a3d..e63dcf8d45567b0851393c2cea7a0d630afa20cd 100644
--- a/drivers/net/ipa/data/ipa_data-v4.7.c
+++ b/drivers/net/ipa/data/ipa_data-v4.7.c
@@ -38,8 +38,8 @@ enum ipa_rsrc_group_id {
 /* QSB configuration data for an SoC having IPA v4.7 */
 static const struct ipa_qsb_data ipa_qsb_data[] = {
 	[IPA_QSB_MASTER_DDR] = {
-		.max_writes		= 8,
-		.max_reads		= 0,	/* no limit (hardware max) */
+		.max_writes		= 12,
+		.max_reads		= 13,
 		.max_reads_beats	= 120,
 	},
 };

-- 
2.48.1


