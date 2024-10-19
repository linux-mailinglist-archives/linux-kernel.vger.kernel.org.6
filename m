Return-Path: <linux-kernel+bounces-373012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8F79A5097
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 21:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437D71F211C4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 19:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000161922D9;
	Sat, 19 Oct 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ValaT436"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F541917C8;
	Sat, 19 Oct 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729367742; cv=none; b=stBpdE/LzATCehzGfoYfOg/fvRZzYfL52w+iDIt7e30U296g36sfdya2UHhQmF21IsCWIB961GIzdvln3N2NYfvcdyzfVpr+5RKniIFHda/lgs6j/QJ/r/CCcdYb1x0gRX4gl4ndYtWX4cTngzJK5/O4YvBQil8ilptqUmuCwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729367742; c=relaxed/simple;
	bh=3YzDJtGgEsBQV09adTrsUWDISVwgI5xvmQh03TrS9RI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gcMAnthkKKJQG+lGjFRUoK9co+YB7lrH1nNegP55xnHrtoGhysNud9wYgaavMr7Hrm6k1ogkUzODhNzuS7+i6SadC8cnE0IMi0Erp9y7k3rYrzAgRMp6Ut8SSBTOignmmRku4wq4XKrnRDZ8UB1pBADzD/1VRnVK2vQtNbH2QZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ValaT436; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea8d7341e6so2408702a12.3;
        Sat, 19 Oct 2024 12:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729367739; x=1729972539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NL2p85b0pJ2aUHZll7jQWQmYBswCfn3xX90Xd1KWwm8=;
        b=ValaT436ZoDVZ7o2LinfvhFTckWaTE8atM+F9duJlPKAT7A77nQXBgB2U/MOFVTr3L
         maIuqN7yZ3JkISCfOXN0Gi0NEPe0hQiVRTX7L7G5Bdd/cRg6QlIx0OasR1Gn6kYa1C+m
         Z3j5YEu3mtynhafI3r6T1VymX5JKRIiEQ5OPe4VEGiVuqpMBkjgpPXRFhKvJXlzIhtjY
         SfNYoIhE5WGJ9UgY00rLRSKC/4rjz9nbxyb44++tFTdzFJtObg3JmGqmziYOH7H+wJm/
         88zwZ0z6rDiEQaqYwTS4qDAOy0M+XFqla/T0jHNxHQjyOR0ULYxhe5b2PIhGhf4vDn8b
         JZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729367739; x=1729972539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NL2p85b0pJ2aUHZll7jQWQmYBswCfn3xX90Xd1KWwm8=;
        b=n0tyHdOLXpHoejlzHcFZnm+gBstdZdxB9/JnLwvldMgeOF4S+eMTpzPNyxkjHlWDRv
         ng3q77g4JKnR/eNyjoOsFZDwNW16pCTjw7oULN2El/Wv6l74RTSpmkUan3iW7zhpGajn
         HAVNhzp7c6og1+Bfq8Mv93Hrm2vLNsXYAkvjmAQXHvjOSBUHYDflVYpjeBbDJ0quffCH
         h9zR7eHYXie58IYQCkoM/yN24Q9l+lC3nuyuThO4ojydU37BStMIL/zh5nHbfOOtaRD8
         fl93IK+iBa0iWkp6MCvB95fbL7A2qqysbyf+Sw5z18aH49Pgt7E4aHR9TW6yb9Qlyv5u
         bbdA==
X-Forwarded-Encrypted: i=1; AJvYcCWnpJUX3bOov854wp1NxjeILAYEfm67Obp/CTtZPUiAzCBKhAL/JKZTSKThhEgzWShF0nsRJ50iQfNpxng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnVCWkCgf+B0x6Vy4lo61rwMfwVXDv6wGH7+QRclNpJzUrNcT
	p5eeBZNGMnGmpIrYtd674/If900L+yPuv1zlRJpCiNBF/Vy/7+XB
X-Google-Smtp-Source: AGHT+IEO8I5gcyZMFJN2Y315SbCjIOMPlLyq4rx/Fr+BhSEemycqRnYvbo7i5iCQeLN2I9Or1mXUfg==
X-Received: by 2002:a05:6a21:114f:b0:1d6:5f3d:4ab7 with SMTP id adf61e73a8af0-1d92c503c07mr9694576637.22.1729367739330;
        Sat, 19 Oct 2024 12:55:39 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:183b:c6cf:8f19:74f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab1dc5esm125133a12.25.2024.10.19.12.55.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Oct 2024 12:55:37 -0700 (PDT)
From: anish kumar <yesanishhere@gmail.com>
To: jassisinghbrar@gmail.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH 1/2] mailbox: Documentation: remove the old documentation
Date: Sat, 19 Oct 2024 12:55:33 -0700
Message-Id: <20241019195534.79603-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation of better and latest documentation,
remove the current documentation.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/driver-api/mailbox.rst | 129 ---------------------------
 1 file changed, 129 deletions(-)
 delete mode 100644 Documentation/driver-api/mailbox.rst

diff --git a/Documentation/driver-api/mailbox.rst b/Documentation/driver-api/mailbox.rst
deleted file mode 100644
index 0ed95009cc30..000000000000
--- a/Documentation/driver-api/mailbox.rst
+++ /dev/null
@@ -1,129 +0,0 @@
-============================
-The Common Mailbox Framework
-============================
-
-:Author: Jassi Brar <jaswinder.singh@linaro.org>
-
-This document aims to help developers write client and controller
-drivers for the API. But before we start, let us note that the
-client (especially) and controller drivers are likely going to be
-very platform specific because the remote firmware is likely to be
-proprietary and implement non-standard protocol. So even if two
-platforms employ, say, PL320 controller, the client drivers can't
-be shared across them. Even the PL320 driver might need to accommodate
-some platform specific quirks. So the API is meant mainly to avoid
-similar copies of code written for each platform. Having said that,
-nothing prevents the remote f/w to also be Linux based and use the
-same api there. However none of that helps us locally because we only
-ever deal at client's protocol level.
-
-Some of the choices made during implementation are the result of this
-peculiarity of this "common" framework.
-
-
-
-Controller Driver (See include/linux/mailbox_controller.h)
-==========================================================
-
-
-Allocate mbox_controller and the array of mbox_chan.
-Populate mbox_chan_ops, except peek_data() all are mandatory.
-The controller driver might know a message has been consumed
-by the remote by getting an IRQ or polling some hardware flag
-or it can never know (the client knows by way of the protocol).
-The method in order of preference is IRQ -> Poll -> None, which
-the controller driver should set via 'txdone_irq' or 'txdone_poll'
-or neither.
-
-
-Client Driver (See include/linux/mailbox_client.h)
-==================================================
-
-
-The client might want to operate in blocking mode (synchronously
-send a message through before returning) or non-blocking/async mode (submit
-a message and a callback function to the API and return immediately).
-
-::
-
-	struct demo_client {
-		struct mbox_client cl;
-		struct mbox_chan *mbox;
-		struct completion c;
-		bool async;
-		/* ... */
-	};
-
-	/*
-	* This is the handler for data received from remote. The behaviour is purely
-	* dependent upon the protocol. This is just an example.
-	*/
-	static void message_from_remote(struct mbox_client *cl, void *mssg)
-	{
-		struct demo_client *dc = container_of(cl, struct demo_client, cl);
-		if (dc->async) {
-			if (is_an_ack(mssg)) {
-				/* An ACK to our last sample sent */
-				return; /* Or do something else here */
-			} else { /* A new message from remote */
-				queue_req(mssg);
-			}
-		} else {
-			/* Remote f/w sends only ACK packets on this channel */
-			return;
-		}
-	}
-
-	static void sample_sent(struct mbox_client *cl, void *mssg, int r)
-	{
-		struct demo_client *dc = container_of(cl, struct demo_client, cl);
-		complete(&dc->c);
-	}
-
-	static void client_demo(struct platform_device *pdev)
-	{
-		struct demo_client *dc_sync, *dc_async;
-		/* The controller already knows async_pkt and sync_pkt */
-		struct async_pkt ap;
-		struct sync_pkt sp;
-
-		dc_sync = kzalloc(sizeof(*dc_sync), GFP_KERNEL);
-		dc_async = kzalloc(sizeof(*dc_async), GFP_KERNEL);
-
-		/* Populate non-blocking mode client */
-		dc_async->cl.dev = &pdev->dev;
-		dc_async->cl.rx_callback = message_from_remote;
-		dc_async->cl.tx_done = sample_sent;
-		dc_async->cl.tx_block = false;
-		dc_async->cl.tx_tout = 0; /* doesn't matter here */
-		dc_async->cl.knows_txdone = false; /* depending upon protocol */
-		dc_async->async = true;
-		init_completion(&dc_async->c);
-
-		/* Populate blocking mode client */
-		dc_sync->cl.dev = &pdev->dev;
-		dc_sync->cl.rx_callback = message_from_remote;
-		dc_sync->cl.tx_done = NULL; /* operate in blocking mode */
-		dc_sync->cl.tx_block = true;
-		dc_sync->cl.tx_tout = 500; /* by half a second */
-		dc_sync->cl.knows_txdone = false; /* depending upon protocol */
-		dc_sync->async = false;
-
-		/* ASync mailbox is listed second in 'mboxes' property */
-		dc_async->mbox = mbox_request_channel(&dc_async->cl, 1);
-		/* Populate data packet */
-		/* ap.xxx = 123; etc */
-		/* Send async message to remote */
-		mbox_send_message(dc_async->mbox, &ap);
-
-		/* Sync mailbox is listed first in 'mboxes' property */
-		dc_sync->mbox = mbox_request_channel(&dc_sync->cl, 0);
-		/* Populate data packet */
-		/* sp.abc = 123; etc */
-		/* Send message to remote in blocking mode */
-		mbox_send_message(dc_sync->mbox, &sp);
-		/* At this point 'sp' has been sent */
-
-		/* Now wait for async chan to be done */
-		wait_for_completion(&dc_async->c);
-	}
-- 
2.39.3 (Apple Git-146)


