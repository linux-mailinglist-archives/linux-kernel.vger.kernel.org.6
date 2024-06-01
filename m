Return-Path: <linux-kernel+bounces-198042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977978D72BA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BF3281794
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4729944C93;
	Sat,  1 Jun 2024 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Y2zUpNiB"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277FA14A96;
	Sat,  1 Jun 2024 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717284374; cv=none; b=txmcufeXL5pSB7haxQKqkfOWXtEU7NKxvkFOqosQbJMJ+uy/ThbJMutvQKtguVVvQUDwmhuSoyOSXULztGSrRc1bSp8cdnhKty0u7wWAxBvAtRahwPLhMnQaed0SP3Xdtj6yjONZLDSi7LiNhZA5gSE0vVFcEcSVQ9cfIs5DtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717284374; c=relaxed/simple;
	bh=QPUlfK6GFJ0fHyLlwqfDeRFIf41n+RJclyTaY7KVufE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TC4G5LfMa2ifVXGOawEPqLHj0jJvggZHdnvRNICNPcBIfkP363dU67b+PHee3o6XwspdZ32stYojGBiF3LE0RMsHEevGGw/Td+ugPF2xqEtxxQKB+foQtRxjk4Dc9VlEu/LiM87EvN9dAxfppUd+XLSGz31ReRU+Igma2HpCx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Y2zUpNiB; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=y3toXmjpE9FC/9nFEs8AsST4kK6tsu5EB+9tVoO4zzI=; b=Y2zUpNiB/hULCH7b
	PXwi63YHwj1Acizrz4gbxnX5hrKfgMbb8s4PFq+HSb8ewOzVTPwYwIo0t/XILqn8m+qA6dG3WNMis
	AeuSTyYsJbMXeMy9OA3whhJUgCtC7bwRtlBbQePV/k/eUjZDyn60ftXbTGoMsEeIg6XW3bOZUJuiv
	u4ejGw/Cb/2V3xoYjYUcD0blOwmNR4Sth7N6JFkfwOMeQocujlODvEzNbkd0APlz9q7vwvdd8gXDL
	nfuj0jZmnD/HO/aY4QY/h4ST+cvZFCJWt3DeYlW671WqjjLiKLpBDrd2sLcZ/QuMszUjQ49rCy902
	ZssT6wp4lyFN/gEjsg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDY6v-003lo2-2B;
	Sat, 01 Jun 2024 23:26:06 +0000
From: linux@treblig.org
To: oleksandr_andrushchenko@epam.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ALSA: xen-front: remove unused struct 'alsa_sndif_hw_param'
Date: Sun,  2 Jun 2024 00:26:04 +0100
Message-ID: <20240601232604.198662-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'alsa_sndif_hw_param' has been unused since the original
commit 1cee559351a7 ("ALSA: xen-front: Implement ALSA virtual sound
driver").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 sound/xen/xen_snd_front_alsa.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index 31b5dc0f34d2..b229eb6f7057 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -69,11 +69,6 @@ struct alsa_sndif_sample_format {
 	snd_pcm_format_t alsa;
 };
 
-struct alsa_sndif_hw_param {
-	u8 sndif;
-	snd_pcm_hw_param_t alsa;
-};
-
 static const struct alsa_sndif_sample_format ALSA_SNDIF_FORMATS[] = {
 	{
 		.sndif = XENSND_PCM_FORMAT_U8,
-- 
2.45.1


