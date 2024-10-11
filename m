Return-Path: <linux-kernel+bounces-361575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0004499AA00
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0421284B05
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7BD1C245D;
	Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FE1BDABD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667818; cv=none; b=Gpf7rSOewBtwhUkhxD4q9wu3Lpb6aM2HUEJ8ha8xtJEW+Wxg0FnnnUuzeNPngF235ay+oDohIo1mlhveyzSUlKlh81Oih/YxgNgz7nlTgu9x6oT8Q7y6XRpIXUtTdgUj2G73+2K7MrOy88LbTZqnfMuH0NHp/DnvI+jKKEDSAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667818; c=relaxed/simple;
	bh=fVc/pKVvn61lDZ3Pcaw+QbONKopItCa+PSXF7ERArW4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Qm8pdPVkXGRXU+1RNoLCjiGQrLKLumsE9m4zBosrvxqLXs80zbzl/86Bs8pqbhSBQk/bxuj4z5UJ/3QJWjj7XejeZn5c8r5n6hSuVCIqHgk0AacqRxnQrysJOqusb/oQoTFRcEi1KraHCkPZWq/5cSfdqAJgN40ZlUujC43DktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B588AC4CECE;
	Fri, 11 Oct 2024 17:30:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1szJTA-00000001Tyr-0sQ7;
	Fri, 11 Oct 2024 13:30:28 -0400
Message-ID: <20241011173028.071613598@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 11 Oct 2024 13:30:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Ba Jing <bajing@cmss.chinamobile.com>
Subject: [for-next][PATCH 2/9] tools/rv: Correct the grammatical errors in the comments
References: <20241011173010.441043942@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Ba Jing <bajing@cmss.chinamobile.com>

The form of "print" should be consistent with "parses".

Link: https://lore.kernel.org/20240902233408.8684-1-bajing@cmss.chinamobile.com
Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rv/src/in_kernel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index f04479ecc96c..f2bbc75a76f4 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -332,7 +332,7 @@ static void ikm_print_header(struct trace_seq *s)
  * ikm_event_handler - callback to handle event events
  *
  * Called any time a rv:"monitor"_event events is generated.
- * It parses and print event.
+ * It parses and prints event.
  */
 static int
 ikm_event_handler(struct trace_seq *s, struct tep_record *record,
@@ -384,7 +384,7 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
  * ikm_error_handler - callback to handle error events
  *
  * Called any time a rv:"monitor"_errors events is generated.
- * It parses and print event.
+ * It parses and prints event.
  */
 static int
 ikm_error_handler(struct trace_seq *s, struct tep_record *record,
-- 
2.45.2



