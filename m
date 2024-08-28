Return-Path: <linux-kernel+bounces-305116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B09629C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEF11C22464
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3E1891D1;
	Wed, 28 Aug 2024 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Rh/pjDuJ"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333118030
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854001; cv=none; b=AnZGiocpQDD/ArChpZnoaWLgMlzAdovbrUPiCCfub5GOGPj8+uNEh6JuF5kYeMDzH2eAjZlhlAopXK9WL7XtBW/5BoVrFQa4qJxTURu/Xv8+9WkO4Ym7auhJU8LZk+cAlpoTCpllg0uufjfGaoFu8oyfpmC+5ymhn6S4R888jjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854001; c=relaxed/simple;
	bh=otedDKXWRlErpy6D3v6S5UyI+6IgGWr+5u1rG34vxcQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZAYb2WvlmP66lmb5dVMQkh/HscY8UVfekPnEp3Ynw3LD6KQSQl7BaMFaLP8V7aXhtzokx9ZsJ19rwVTbPzrxGYzAwc0VU93kXqzreEkeKg9YIEihY2JwzIIcDD7w4r/p7QDPMOxBoXcOfbn+lAtlLKTq+M8/g/vaizK5Dc9TdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Rh/pjDuJ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1724853991; x=1725113191;
	bh=vPvncXPECDixTc76akVoXBodonoMLQRoRoMAD+A7dKQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Rh/pjDuJ9ib44eTecS/a14DMJLhWFnHamHzpPhlUQJKGwvoFITe+B+vXrlaGeNnYl
	 ziLpJTLshwFo1sH8m59lH4Dfz5VrVi/ySpmZ65Z40Ra2zgcTO9JcmI70zZSy1w/qJ5
	 ruXkq80VTQI7DLo7izkHqP4IS4C+vBEzpNZ8R3Lux3F3a0ZZrn4M86OFErm1SMiq3L
	 jIsHB75tEQ9OigsZ2ZnH92cTLI/hpdd7g7fj9X6uhtoXPaUh42w/wzQsv8KK21H7Ja
	 hhJxAHndPdjKvUNWGK7SmUGHJqvdTBwoQnoQKhzzNkneVFdHeIFivR892G7PAHkfV2
	 dG7nKmHL4gYWQ==
Date: Wed, 28 Aug 2024 14:06:25 +0000
To: perex@perex.cz, tiwai@suse.com
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH] sound: core: Fix issues detected by checkpatch
Message-ID: <20240828140555.68565-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 11801dcb88d86c23edff23e64d7df05fecee8e70
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Running checkpatch.pl on sound_core.c resulted in:
total: 75 errors, 37 warnings, 617 lines checked

This patch fixes most of them, leaving two warnings:
WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err=
(dev, ... then pr_err(...  to printk(KERN_ERR ...
+=09printk(KERN_ERR "Sound device %d went missing!\n", unit);

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err=
(dev, ... then pr_err(...  to printk(KERN_ERR ...
+=09=09printk(KERN_ERR "soundcore: sound device already in use.\n");

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 sound/sound_core.c | 157 +++++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 85 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index d81fed1c1226..875ab0257904 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -70,15 +70,15 @@ module_exit(cleanup_soundcore);
 #ifdef CONFIG_SOUND_OSS_CORE
 /*
  *=09OSS sound core handling. Breaks out sound functions to submodules
- *=09
+ *
  *=09Author:=09=09Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
  *=09Fixes:
  *
  *                         --------------------
- *=20
+ *
  *=09Top level handler for the sound subsystem. Various devices can
- *=09plug into this. The fact they don't all go via OSS doesn't mean=20
+ *=09plug into this. The fact they don't all go via OSS doesn't mean
  *=09they don't have to implement the OSS API. There is a lot of logic
  *=09to keeping much of the OSS weight out of the code in a compatibility
  *=09module, but it's up to the driver to rember to load it...
@@ -107,8 +107,7 @@ module_exit(cleanup_soundcore);
=20
 #define SOUND_STEP 16
=20
-struct sound_unit
-{
+struct sound_unit {
 =09int unit_minor;
 =09const struct file_operations *unit_fops;
 =09struct sound_unit *next;
@@ -143,8 +142,7 @@ module_param(preclaim_oss, int, 0444);
=20
 static int soundcore_open(struct inode *, struct file *);
=20
-static const struct file_operations soundcore_fops =3D
-{
+static const struct file_operations soundcore_fops =3D {
 =09/* We must have an owner or the module locking fails */
 =09.owner=09=3D THIS_MODULE,
 =09.open=09=3D soundcore_open,
@@ -156,70 +154,68 @@ static const struct file_operations soundcore_fops =
=3D
  *=09join into it. Called with the lock asserted
  */
=20
-static int __sound_insert_unit(struct sound_unit * s, struct sound_unit **=
list, const struct file_operations *fops, int index, int low, int top)
+static int __sound_insert_unit(struct sound_unit *s, struct sound_unit **l=
ist, const struct file_operations *fops, int index, int low, int top)
 {
-=09int n=3Dlow;
+=09int n =3D low;
=20
 =09if (index < 0) {=09/* first free */
=20
-=09=09while (*list && (*list)->unit_minor<n)
-=09=09=09list=3D&((*list)->next);
+=09=09while (*list && (*list)->unit_minor < n)
+=09=09=09list =3D &((*list)->next);
=20
-=09=09while(n<top)
-=09=09{
+=09=09while (n < top) {
 =09=09=09/* Found a hole ? */
-=09=09=09if(*list=3D=3DNULL || (*list)->unit_minor>n)
+=09=09=09if (*list =3D=3D NULL || (*list)->unit_minor > n)
 =09=09=09=09break;
-=09=09=09list=3D&((*list)->next);
-=09=09=09n+=3DSOUND_STEP;
+=09=09=09list =3D &((*list)->next);
+=09=09=09n +=3D SOUND_STEP;
 =09=09}
=20
-=09=09if(n>=3Dtop)
+=09=09if (n >=3D top)
 =09=09=09return -ENOENT;
 =09} else {
 =09=09n =3D low+(index*16);
 =09=09while (*list) {
-=09=09=09if ((*list)->unit_minor=3D=3Dn)
+=09=09=09if ((*list)->unit_minor =3D=3D n)
 =09=09=09=09return -EBUSY;
-=09=09=09if ((*list)->unit_minor>n)
+=09=09=09if ((*list)->unit_minor > n)
 =09=09=09=09break;
-=09=09=09list=3D&((*list)->next);
+=09=09=09list =3D &((*list)->next);
 =09=09}
-=09}=09
-=09=09
+=09}
+
 =09/*
 =09 *=09Fill it in
 =09 */
-=09=20
-=09s->unit_minor=3Dn;
-=09s->unit_fops=3Dfops;
-=09
+
+=09s->unit_minor =3D n;
+=09s->unit_fops =3D fops;
+
 =09/*
 =09 *=09Link it
 =09 */
-=09=20
-=09s->next=3D*list;
-=09*list=3Ds;
-=09
-=09
+
+=09s->next =3D *list;
+=09*list =3D s;
+
+
 =09return n;
 }
=20
 /*
  *=09Remove a node from the chain. Called with the lock asserted
  */
-=20
+
 static struct sound_unit *__sound_remove_unit(struct sound_unit **list, in=
t unit)
 {
-=09while(*list)
-=09{
-=09=09struct sound_unit *p=3D*list;
-=09=09if(p->unit_minor=3D=3Dunit)
-=09=09{
-=09=09=09*list=3Dp->next;
+=09while (*list) {
+=09=09struct sound_unit *p =3D *list;
+
+=09=09if (p->unit_minor =3D=3D unit) {
+=09=09=09*list =3D p->next;
 =09=09=09return p;
 =09=09}
-=09=09list=3D&(p->next);
+=09=09list =3D &(p->next);
 =09}
 =09printk(KERN_ERR "Sound device %d went missing!\n", unit);
 =09return NULL;
@@ -248,7 +244,7 @@ static int sound_insert_unit(struct sound_unit **list, =
const struct file_operati
 retry:
 =09r =3D __sound_insert_unit(s, list, fops, index, low, top);
 =09spin_unlock(&sound_loader_lock);
-=09
+
 =09if (r < 0)
 =09=09goto fail;
 =09else if (r < SOUND_STEP)
@@ -291,7 +287,7 @@ static int sound_insert_unit(struct sound_unit **list, =
const struct file_operati
  *=09completed the removal before their file operations become
  *=09invalid.
  */
- =09
+
 static void sound_remove_unit(struct sound_unit **list, int unit)
 {
 =09struct sound_unit *p;
@@ -335,7 +331,7 @@ static struct sound_unit *chains[SOUND_STEP];
  *=09register_sound_special_device - register a special sound node
  *=09@fops: File operations for the driver
  *=09@unit: Unit number to allocate
- *      @dev: device pointer
+ *=09@dev: device pointer
  *
  *=09Allocate a special sound device by minor number from the sound
  *=09subsystem.
@@ -343,7 +339,7 @@ static struct sound_unit *chains[SOUND_STEP];
  *=09Return: The allocated number is returned on success. On failure,
  *=09a negative error code is returned.
  */
-=20
+
 int register_sound_special_device(const struct file_operations *fops, int =
unit,
 =09=09=09=09  struct device *dev)
 {
@@ -353,69 +349,66 @@ int register_sound_special_device(const struct file_o=
perations *fops, int unit,
 =09char _name[16];
=20
 =09switch (chain) {
-=09    case 0:
+=09case 0:
 =09=09name =3D "mixer";
 =09=09break;
-=09    case 1:
+=09case 1:
 =09=09name =3D "sequencer";
 =09=09if (unit >=3D SOUND_STEP)
 =09=09=09goto __unknown;
 =09=09max_unit =3D unit + 1;
 =09=09break;
-=09    case 2:
+=09case 2:
 =09=09name =3D "midi";
 =09=09break;
-=09    case 3:
+=09case 3:
 =09=09name =3D "dsp";
 =09=09break;
-=09    case 4:
+=09case 4:
 =09=09name =3D "audio";
 =09=09break;
-=09    case 5:
+=09case 5:
 =09=09name =3D "dspW";
 =09=09break;
-=09    case 8:
+=09case 8:
 =09=09name =3D "sequencer2";
 =09=09if (unit >=3D SOUND_STEP)
 =09=09=09goto __unknown;
 =09=09max_unit =3D unit + 1;
 =09=09break;
-=09    case 9:
+=09case 9:
 =09=09name =3D "dmmidi";
 =09=09break;
-=09    case 10:
+=09case 10:
 =09=09name =3D "dmfm";
 =09=09break;
-=09    case 12:
+=09case 12:
 =09=09name =3D "adsp";
 =09=09break;
-=09    case 13:
+=09case 13:
 =09=09name =3D "amidi";
 =09=09break;
-=09    case 14:
+=09case 14:
 =09=09name =3D "admmidi";
 =09=09break;
-=09    default:
-=09    =09{
-=09=09    __unknown:
+=09default: {
+__unknown:
 =09=09=09sprintf(_name, "unknown%d", chain);
-=09=09    =09if (unit >=3D SOUND_STEP)
-=09=09    =09=09strcat(_name, "-");
-=09=09    =09name =3D _name;
+=09=09=09if (unit >=3D SOUND_STEP)
+=09=09=09=09strcat(_name, "-");
+=09=09=09name =3D _name;
 =09=09}
 =09=09break;
 =09}
 =09return sound_insert_unit(&chains[chain], fops, -1, unit, max_unit,
 =09=09=09=09 name, 0600, dev);
 }
-=20
 EXPORT_SYMBOL(register_sound_special_device);
=20
 int register_sound_special(const struct file_operations *fops, int unit)
 {
 =09return register_sound_special_device(fops, unit, NULL);
 }
-
 EXPORT_SYMBOL(register_sound_special);
=20
 /**
@@ -435,14 +428,13 @@ int register_sound_mixer(const struct file_operations=
 *fops, int dev)
 =09return sound_insert_unit(&chains[0], fops, dev, 0, 128,
 =09=09=09=09 "mixer", 0600, NULL);
 }
-
 EXPORT_SYMBOL(register_sound_mixer);
=20
 /*
  *=09DSP's are registered as a triple. Register only one and cheat
  *=09in open - see below.
  */
-=20
+
 /**
  *=09register_sound_dsp - register a DSP device
  *=09@fops: File operations for the driver
@@ -463,7 +455,6 @@ int register_sound_dsp(const struct file_operations *fo=
ps, int dev)
 =09return sound_insert_unit(&chains[3], fops, dev, 3, 131,
 =09=09=09=09 "dsp", 0600, NULL);
 }
-
 EXPORT_SYMBOL(register_sound_dsp);
=20
 /**
@@ -480,7 +471,6 @@ void unregister_sound_special(int unit)
 {
 =09sound_remove_unit(&chains[unit % SOUND_STEP], unit);
 }
-=20
 EXPORT_SYMBOL(unregister_sound_special);
=20
 /**
@@ -495,7 +485,6 @@ void unregister_sound_mixer(int unit)
 {
 =09sound_remove_unit(&chains[0], unit);
 }
-
 EXPORT_SYMBOL(unregister_sound_mixer);
=20
 /**
@@ -512,20 +501,17 @@ void unregister_sound_dsp(int unit)
 {
 =09sound_remove_unit(&chains[3], unit);
 }
-
-
 EXPORT_SYMBOL(unregister_sound_dsp);
=20
 static struct sound_unit *__look_for_unit(int chain, int unit)
 {
 =09struct sound_unit *s;
-=09
-=09s=3Dchains[chain];
-=09while(s && s->unit_minor <=3D unit)
-=09{
-=09=09if(s->unit_minor=3D=3Dunit)
+
+=09s =3D chains[chain];
+=09while (s && s->unit_minor <=3D unit) {
+=09=09if (s->unit_minor =3D=3D unit)
 =09=09=09return s;
-=09=09s=3Ds->next;
+=09=09s =3D s->next;
 =09}
 =09return NULL;
 }
@@ -537,14 +523,13 @@ static int soundcore_open(struct inode *inode, struct=
 file *file)
 =09struct sound_unit *s;
 =09const struct file_operations *new_fops =3D NULL;
=20
-=09chain=3Dunit&0x0F;
-=09if(chain=3D=3D4 || chain=3D=3D5)=09/* dsp/audio/dsp16 */
-=09{
-=09=09unit&=3D0xF0;
-=09=09unit|=3D3;
-=09=09chain=3D3;
+=09chain =3D unit&0x0F;
+=09if (chain =3D=3D 4 || chain =3D=3D 5) {=09/* dsp/audio/dsp16 */
+=09=09unit &=3D 0xF0;
+=09=09unit |=3D 3;
+=09=09chain =3D 3;
 =09}
-=09
+
 =09spin_lock(&sound_loader_lock);
 =09s =3D __look_for_unit(chain, unit);
 =09if (s)
@@ -598,8 +583,10 @@ MODULE_ALIAS_CHARDEV_MAJOR(SOUND_MAJOR);
=20
 static void cleanup_oss_soundcore(void)
 {
-=09/* We have nothing to really do here - we know the lists must be
-=09   empty */
+=09/*
+=09 * We have nothing to really do here - we know the lists must be
+=09 * empty
+=09 */
 =09unregister_chrdev(SOUND_MAJOR, "sound");
 }
=20
--=20
2.34.1



