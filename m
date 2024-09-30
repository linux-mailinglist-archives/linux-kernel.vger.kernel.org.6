Return-Path: <linux-kernel+bounces-343856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4550398A061
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B025EB252E7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471381922DB;
	Mon, 30 Sep 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="h/tOh7AW"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2019047C;
	Mon, 30 Sep 2024 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695308; cv=none; b=ZHkPIO4QlwxT5DQHaRGOeOzJteBOcv3RvqmQjtzNIQdi7TZn49cwNSbjrp8UQJTfI7bkO1JR+xRJ9+uLBpmcBN0PhZhsDE2x8RHMcdJVnOxl7TD4uTJZ4mMMIx/XvQTUKHeYWi5dTBBxDQiiic7T43L8K9DAUs83dqzedjcfQWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695308; c=relaxed/simple;
	bh=zY5fLQx5eAob2m8RVjDYU4PsTYf3zrfWO5TzD8j7olM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTIgtScIi2M5fWTL0EPT8nMP2KRWQZzH+XWHfbpqDiWT37FItHBOP1192sSGbfjCrUwxdsjQDs/crfaOceWF4z4phSdFWkV1w6tgUXkO6GWSEkTIUN97bBo+AgMu5SDSm0lcCI8R5wpRYnPEDbRQ/gj1QwsOEXATU3J5trhee/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=h/tOh7AW; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Kr5dOKa8hZztibt/ZHFgdGNFDX6J60qxqGmrL527Zk=;
  b=h/tOh7AWoEhfvDreNIbqZe2D24GWlprTaC7/tBKl3GHFD5uorJ1ghT3o
   I4gvxyIFeb3Yka9YAeLAXqw6VAxILrf6iCAaSRAdoKP2rU7VJNigOb4mF
   URE8UR4/IyJDo4uTYNplKRwLCjjeRCFMyo8fXhDNfjkD+lcJv8ScgmqNg
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956883"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Vinod Koul <vkoul@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/35] soundwire: stream: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:20:58 +0200
Message-Id: <20240930112121.95324-13-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/soundwire/stream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 7aa4900dcf31..0e1875c31a3d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1977,9 +1977,9 @@ EXPORT_SYMBOL(sdw_stream_remove_master);
  *
  * @slave: SDW Slave instance
  * @stream_config: Stream configuration for audio stream
- * @stream: SoundWire stream
  * @port_config: Port configuration for audio stream
  * @num_ports: Number of ports
+ * @stream: SoundWire stream
  *
  * It is expected that Slave is added before adding Master
  * to the Stream.


